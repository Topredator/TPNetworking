//
//  TPHttpManager+TPRacExtension.m
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPHttpManager+TPRacExtension.h"

@implementation TPHttpManager (TPRacExtension)
- (RACSignal *)rac_getTask:(__kindof TPHttpTask *)task {
    return [self fetchSignalWithTask:task method:TPHTTPMethodTypeGet];
}
- (RACSignal *)rac_postTask:(__kindof TPHttpTask *)task {
    return [self fetchSignalWithTask:task method:TPHTTPMethodTypePost];
}

- (RACSignal *)fetchSignalWithTask:(TPHttpTask *)task method:(TPHTTPMethodType)method {
    return [[[RACSignal startEagerlyWithScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityHigh]
                    block:^(id<RACSubscriber>  _Nonnull subscriber) {
                        [self sendTask:task method:method success:^(__kindof TPHttpTask * _Nonnull task, id  _Nonnull response) {
                            [subscriber sendNext:task];
                            [subscriber sendCompleted];
                        } failure:^(__kindof TPHttpTask * _Nonnull task, NSError * _Nonnull error) {
                            [subscriber sendError:error];
                        }];
                    }] setNameWithFormat:@"Signal_Resume_%@", task] replayLast];
}
@end
