//
//  TPHttpDataSerialization.m
//  TPNetwork_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPHttpDataSerialization.h"

#import <TPNetworking/YYModel.h>
@implementation TPHTTPDataRequestSerializer
- (instancetype)init {
    self = [super init];
    if (self) {
        self.timeoutInterval = 10;
    }
    return self;
}
#pragma mark ==================  TPHTTPRequestSerialization   ==================
- (id)encodeHTTPRequestParameters:(id)parameters task:(__kindof TPHttpTask *)task error:(NSError *__autoreleasing *)error {
    if (!parameters) {
        parameters = [task yy_modelToJSONObject];
    }
    return parameters;
}
@end
@implementation TPHTTPDataResponseSerializer
#pragma mark ==================  TPHTTPResponseSerialization   ==================
- (id)decodeHTTPResponseObject:(id)responseObject task:(__kindof TPHttpTask *)task error:(NSError *__autoreleasing *)error {
    // 解析错误，数据格式异常
//    if (!responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *info = @{NSLocalizedDescriptionKey: @"返回数据异常"};
//        *error = [NSError errorWithDomain:TPHTTPResponseSerializationDomain code:0 userInfo:info];
//        return responseObject;
//    }
//    NSInteger resultCode = [responseObject[@"code"] integerValue];
//    if (resultCode != 1) { // resultCode 不为1，表示错误
//        NSString *message = responseObject[@"msg"];
//        message = message ?: @"数据异常";
//        NSDictionary *info = @{NSLocalizedDescriptionKey: message};
//        *error = [NSError errorWithDomain:TPHTTPResponseUnderlyingDomain code:resultCode userInfo:info];
//    } else {
//        [task yy_modelResetWithJSON:responseObject[@"data"]];
//    }
    return responseObject;
}
@end

@implementation TPHttpDataErrorSerializer
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark ==================  TPHTTPErrorSerialization   ==================
- (NSError *)decodeHTTPError:(NSError *)error task:(__kindof TPHttpTask *)task {

    if ([error isRequestSerializationError]) { /// 请求序列化错误
        return [error setUserInfoObject:@"请求数据异常" forKey:NSLocalizedDescriptionKey];
    } else if ([error isResponseSerializationError]) { // 返回数据序列化错误
        return [error setUserInfoObject:@"返回数据异常" forKey:NSLocalizedDescriptionKey];
    } else if ([error isNetworkError]) { // 网络错误
        NSString *msg;
        switch (error.code) {
            case NSURLErrorTimedOut: msg = @"请求超时,请检查网络"; break;
            case NSURLErrorCannotConnectToHost:
            case NSURLErrorNotConnectedToInternet:
            case NSURLErrorCannotFindHost: msg = @"无法连接到服务器"; break;
            case NSURLErrorCancelled: msg = @"请检查网络,已经取消"; break;
            case NSURLErrorBadServerResponse: msg = @"服务器错误"; break;
            default: msg = @"网络异常,请检查网络"; break;
        }
        return [error setUserInfoObject:msg forKey:NSLocalizedDescriptionKey];
    }
    return error;
}
@end
