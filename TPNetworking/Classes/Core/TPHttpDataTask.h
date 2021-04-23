//
//  TPHttpDataTask.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPHttpTask.h"
#import <TPJsonModel/TPJsonModel.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface TPHttpDataTask : TPHttpTask <TPJsonModel>
/**
 持久化 解档获取请求task
 */
+ (instancetype)unarchiveTask;

/**
 持久化地址 根目录为cache目录
 */
+ (NSString *)archivePath;
/**
 持久化 存档
 */
- (void)archiveTask;
// 发送get请求
- (RACSignal *)get;
// 发送post请求
- (RACSignal *)post;
@end

NS_ASSUME_NONNULL_END
