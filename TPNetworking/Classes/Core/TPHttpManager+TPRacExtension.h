//
//  TPHttpManager+TPRacExtension.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPHttpManager.h"
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPHttpManager (TPRacExtension)
/**
 发起get请求
 @param task 数据请求的任务，请求成功时通过参数返回
 @return 异步数据流，当成功返回response的时候，会触发next:的block，当出错的时候，会触发error:的block
 */
- (RACSignal *)rac_getTask:(__kindof TPHttpTask *)task;
/**
 发起post请求
 @param task 数据请求的任务，请求成功时通过参数返回
 @return 异步数据流，当成功返回response的时候，会触发next:的block，当出错的时候，会触发error:的block
 */
- (RACSignal *)rac_postTask:(__kindof TPHttpTask *)task;
@end

NS_ASSUME_NONNULL_END
