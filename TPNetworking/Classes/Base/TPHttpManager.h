//
//  TPHttpManager.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import <AFNetworking/AFNetworking.h>
#import "TPHttpTask.h"
#import "TPHttpSerialization.h"
NS_ASSUME_NONNULL_BEGIN
/// 请求方法类型 默认Post方法
typedef NS_ENUM(NSInteger, TPHTTPMethodType) {
    TPHTTPMethodTypePost = 0,
    TPHTTPMethodTypeGet
};
/// 成功回调
typedef void (^SuccessCompleted)(__kindof TPHttpTask *task, id response);
/// 失败回调
typedef void (^FailureCompleted)(__kindof TPHttpTask *task, NSError *error);

@interface TPHttpManager : AFHTTPSessionManager
/// 请求序列化对象
@property (nonatomic, strong) AFHTTPRequestSerializer <TPHTTPRequestSerialization>*requestSerializer;
/// 返回序列化对象
@property (nonatomic, strong) AFHTTPResponseSerializer <TPHTTPResponseSerialization>*responseSerializer;
/// 错误序列化对象
@property (nonatomic, strong) TPHTTPErrorSerializer <TPHTTPErrorSerialization>*errorSerializer;

/**
 发起Get请求任务

 @param task 请求任务
 @param success 请求成功回调
 @param failure 请求失败回调
 */
- (void)getTask:(__kindof TPHttpTask *)task
        success:(SuccessCompleted)success
        failure:(FailureCompleted)failure;

/**
 发起Post请求任务

 @param task 请求任务
 @param success 请求成功回调
 @param failure 请求失败回调
 */
- (void)postTask:(__kindof TPHttpTask *)task
         success:(SuccessCompleted)success
         failure:(FailureCompleted)failure;
/**
 发送请求任务

 @param task 请求的任务
 @param method 请求方法
 @param success 请求成功的回调
 @param failure 请求失败的回调
 */
- (void)sendTask:(__kindof TPHttpTask *)task
          method:(TPHTTPMethodType)method
         success:(SuccessCompleted)success
         failure:(FailureCompleted)failure;
@end

NS_ASSUME_NONNULL_END
