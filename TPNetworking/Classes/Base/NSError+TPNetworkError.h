//
//  NSError+TPNetworkError.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXTERN NSErrorDomain const TPHTTPRequestSerializationDomain; // 请求数据序列化错误
FOUNDATION_EXTERN NSErrorDomain const TPHTTPResponseSerializationDomain; // 返回数据序列化错误
FOUNDATION_EXTERN NSErrorDomain const TPHTTPResponseUnderlyingDomain; // 返回数据内部潜在的错误


@interface NSError (TPNetworkError)
/**
 是否网络错误

 @return YES : 表示当前网络错误
 */
- (BOOL)isNetworkError;

/**
 是否请求解析错误

 @return YES : 表示请求解析错误
 */
- (BOOL)isRequestSerializationError;

/**
 是否返回数据解析错误

 @return YES : 表示返回数据解析错误
 */
- (BOOL)isResponseSerializationError;

/**
 是否返回数据内部潜在错误

 @return YES : 表示返回数据内部潜在错误
 */
- (BOOL)isResponseUnderlyingError;
/**
 设置错误域并返回新的error对象
 @param domain 新的错误域
 @return 新生成的error对象
 */
- (NSError *)setDomain:(NSString *)domain;

/**
 设置是用户信息
 @param userInfo 用户信息
 @return 新生成的error对象
 */
- (NSError *)setUserInfo:(NSDictionary *)userInfo;

/**
 新增用户信息
 @param object 新的用户信息对象，不能为nil
 @param key 键值，不能为nil
 @return 新生成的error对象
 */
- (NSError *)setUserInfoObject:(id)object forKey:(id<NSCopying>)key;
@end

