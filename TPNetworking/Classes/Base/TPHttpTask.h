//
//  TPHttpTask.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFURLRequestSerialization.h>
#import <CocoaLumberjack/CocoaLumberjack.h>


#pragma mark ==================  Request协议  ==================
@protocol TPHttpRequest <NSObject>
/// 请求地址
@property (nonatomic, readonly) NSURL *requestURL;
@optional
/**
 获取请求序列化之前的参数

 @param error 参数发生错误
 @return 返回请求参数
 */
- (id)fetchHTTPRequestParametersBeforeSerializationWithError:(NSError **)error;
@end

#pragma mark ==================  Response协议   ==================

@protocol TPHttpResponse <NSObject>
/// 网络错误, nil 表示没有错误
@property (nonatomic, readonly) NSError *networkError;
@optional

/**
 设置响应序列化后的返回数据

 @param responseObject 序列化之后的返回数据
 @param error 序列化之后的数据错误（用于处理业务错误）
 */
- (void)setHTTPResponseObjectAfterSerialization:(id)responseObject error:(NSError **)error;
@end


/// 基类 网络调用task对象
@interface TPHttpTask : NSObject <TPHttpRequest, TPHttpResponse, NSCoding, NSCopying>
/// 会话任务
@property (nonatomic, readonly) __kindof NSURLSessionDataTask *sessionTask;
/// 模拟返回数据，默认为NO
@property (nonatomic, assign, getter=isSimulateResponse) BOOL simulateResponse;
/// 后台全量返回数据
@property (nonatomic, strong) id serverTotalResponseData;
/// 表单数据生成器，(用于下载上传)
@property (nonatomic, copy) void (^formDataMaker)(__kindof TPHttpTask *task, id <AFMultipartFormData> formData);
/// 打印日志类型, 默认为DDLogLevelAll
@property (nonatomic, assign) DDLogLevel logLevel;

/**
 @Override 实例化对象
 */
+ (instancetype)task;

/**
 初始化方法

 @param url 请求地址
 */
- (instancetype)initWithRequestURL:(NSURL *)url;

/**
 取消任务
 */
- (void)cancelTask;

/**
 @Override 获取模拟数据，可以异步返回

 @param completed 触发模拟数据返回的回调
 */
- (void)fetchSimulateResponseObjectWithCompleted:(void (^)(id responseObject, NSError *error))completed;

@end
