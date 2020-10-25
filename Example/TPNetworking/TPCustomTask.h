//
//  TPCustomTask.h
//  TPNetwork_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import <TPNetworking/TPNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPCustomTask : TPHttpDataTask
/**
 初始化

 @param url 整个url
 @return 返回请求对象
 */
+ (instancetype)taskWithURL:(NSString *)url;
/**
 初始化

 @param url 只需要传api地址, 不需要域名 如: @"/api/xxxx/xxxx"
 @return 返回请求对象
 */
+ (instancetype)taskWithAPI:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
