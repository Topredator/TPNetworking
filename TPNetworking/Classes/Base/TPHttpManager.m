//
//  TPHttpManager.m
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPHttpManager.h"
#import "TPNetworkPrivate.h"

@implementation TPHttpManager
@dynamic requestSerializer;
@dynamic responseSerializer;

- (void)getTask:(__kindof TPHttpTask *)task success:(SuccessCompleted)success failure:(FailureCompleted)failure {
    [self sendTask:task method:TPHTTPMethodTypeGet success:success failure:failure];
}
- (void)postTask:(__kindof TPHttpTask *)task success:(SuccessCompleted)success failure:(FailureCompleted)failure {
    [self sendTask:task method:TPHTTPMethodTypePost success:success failure:failure];
}
- (void)sendTask:(__kindof TPHttpTask *)task method:(TPHTTPMethodType)method success:(SuccessCompleted)success failure:(FailureCompleted)failure {
    // 请求参数
    id params;
    NSError *error;
    TPLogInfo(task.logLevel, @"🚀%@ %@ for URL: %@", (method == TPHTTPMethodTypePost) ? @"POST" : @"GET", task, task.requestURL);
    /// 序列化前
    if ([task respondsToSelector:@selector(fetchHTTPRequestParametersBeforeSerializationWithError:)]) {
        params = [task fetchHTTPRequestParametersBeforeSerializationWithError:&error];
        if (error) {
            [self handleError:error task:task response:nil success:success failure:failure];
            return;
        }
    }
    /// 序列化
    if ([self.requestSerializer respondsToSelector:@selector(encodeHTTPRequestParameters:task:error:)]) {
        params = [self.requestSerializer encodeHTTPRequestParameters:params task:task error:&error];
        if (error) {
            [self handleError:error task:task response:nil success:success failure:failure];
            return;
        }
    }
    /// 使用了模拟数据
    if (task.simulateResponse) {
        task.sessionTask = nil;
        [self fetchSimulateResponseObjectForTask:task success:success failure:failure];
        return;
    }
    task.sessionTask = [self _sendTask:task method:method parameters:params success:success failure:failure];
}

#pragma mark ==================  private method  ==================
/// 获取模拟数据
- (void)fetchSimulateResponseObjectForTask:(TPHttpTask *)task success:(SuccessCompleted)success failure:(FailureCompleted)failure {
    [task fetchSimulateResponseObjectWithCompleted:^(id responseObject, NSError *error) {
        [self handleResponseObject:responseObject task:task success:success failure:failure];
    }];
}
/// 发起网络请求
- (NSURLSessionDataTask *)_sendTask:(__kindof TPHttpTask *)task method:(TPHTTPMethodType)method parameters:(id)parameters success:(SuccessCompleted)success failure:(FailureCompleted)failure {
    __weak typeof(self) weakSelf = self;
    // 请求地址
    NSString *urlString = [task.requestURL absoluteString];
    // 成功回调
    void (^successBlock)(NSURLSessionDataTask *sessionTask, id responseObject) = ^(NSURLSessionDataTask *sessionTask, id responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf handleResponseObject:responseObject task:task success:success failure:failure];
    };
    // 失败的回调
    void (^failurBlock)(NSURLSessionDataTask *sessionTask, NSError *error) = ^(NSURLSessionDataTask *sessionTask, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf handleError:error task:task response:nil success:success failure:failure];
    };
    // 开始发送请求
    switch (method) {
        case TPHTTPMethodTypePost: {
            if (task.formDataMaker) {
                return [self POST:urlString parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    task.formDataMaker(task, formData);
                } progress:nil success:successBlock failure:failurBlock];
            }
            return [self POST:urlString parameters:parameters headers:nil progress:nil success:successBlock failure:failurBlock];
        }
        default:
            return [self GET:urlString parameters:parameters headers:nil progress:nil success:successBlock failure:failurBlock];
    }
}
/// 处理返回数据
- (void)handleResponseObject:(id)responseObject task:(TPHttpTask *)task success:(SuccessCompleted)success failure:(FailureCompleted)failure {
    id response = responseObject;
    NSError *error;
    // 返回数据序列化
    if ([self.responseSerializer respondsToSelector:@selector(decodeHTTPResponseObject:task:error:)]) {
        response = [self.responseSerializer decodeHTTPResponseObject:response task:task error:&error];
        if (error) {
            task.serverTotalResponseData = [response copy];
            [self handleError:error task:task response:response success:success failure:failure];
            return;
        }
    }
    // 序列化之后
    if ([task respondsToSelector:@selector(setHTTPResponseObjectAfterSerialization:error:)]) {
         [task setHTTPResponseObjectAfterSerialization:response error:&error];
        if (error) {
            task.serverTotalResponseData = [response copy];
            [self handleError:error task:task response:response success:success failure:failure];
            return;
        }
    }
    TPLogInfo(task.logLevel, @"✅%@ request success!", task);
    // 成功回调
    if (success) {
        task.serverTotalResponseData = [response copy];
        success(task, response);
    }
}
/// 处理网络错误
- (void)handleError:(NSError *)error
               task:(TPHttpTask *)task
           response:(id)response
            success:(SuccessCompleted)success
            failure:(FailureCompleted)failure {
    if (self.errorSerializer) {
        error = [self.errorSerializer decodeHTTPError:error task:task];
        task.networkError = error;
        if ([self.errorSerializer.delegate respondsToSelector:@selector(TPHTTPErrorSerializer:didDecodeHTTPError:task:)]) {
            [self.errorSerializer.delegate TPHTTPErrorSerializer:self.errorSerializer didDecodeHTTPError:error task:task];
        }
    } else {
        task.networkError = error;
    }
    if (error) {
        TPLogError(task.logLevel, @"❌%@ request error: %@", task, error);
        if (failure) failure(task, error);
    } else {
        TPLogInfo(task.logLevel, @"✅%@ request success!", task);
        if (success) success(task, response);
    }
}

#pragma mark ==================  lazy method  ==================
- (TPHTTPErrorSerializer<TPHTTPErrorSerialization> *)errorSerializer {
    if (!_errorSerializer) {
        _errorSerializer = [TPHTTPErrorSerializer serializer];
    }
    return _errorSerializer;
}
@end
