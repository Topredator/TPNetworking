//
//  TPHttpSerialization.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import <Foundation/Foundation.h>

#import <AFNetworking/AFNetworking.h>
#import "TPHttpTask.h"
#pragma mark ==================  RequestSerialization   ==================

@protocol TPHTTPRequestSerialization <AFURLRequestSerialization>
@optional
/// 请求参数编码
- (id)encodeHTTPRequestParameters:(id)parameters task:(__kindof TPHttpTask *)task error:(NSError **)error;
@end

#pragma mark ==================  ResponseSerialization   ==================
@protocol TPHTTPResponseSerialization <AFURLResponseSerialization>
@optional
/// 解析返回数据
- (id)decodeHTTPResponseObject:(id)responseObject task:(__kindof TPHttpTask *)task error:(NSError **)error;
@end

#pragma mark ==================  ErrorSerialization   ==================

@protocol TPHTTPErrorSerialization;

@protocol TPHTTPErrorSerializarDelegate <NSObject>
@optional
- (void)TPHTTPErrorSerializer:(id<TPHTTPErrorSerialization>)serializer didDecodeHTTPError:(NSError *)error task:(__kindof TPHttpTask *)task;
@end



@protocol TPHTTPErrorSerialization <NSObject>
/// 错误序列的代理对象
@property (nonatomic, weak) id <TPHTTPErrorSerializarDelegate> delegate;
/**
 解析网络错误

 @param error 网络错误
 @param task 请求任务对象
 @return 解析后的网络错误，如果返回nil，忽略该错误
 */
- (NSError *)decodeHTTPError:(NSError *)error task:(__kindof TPHttpTask *)task;
@end

@interface TPHTTPErrorSerializer : NSObject <TPHTTPErrorSerialization>
/// 初始化
+ (instancetype)serializer;
@end


