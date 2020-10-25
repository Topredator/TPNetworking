//
//  TPCustomTask.m
//  TPNetwork_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPCustomTask.h"
#import <TPNetworking/TPNetworkEnv.h>

#import "TPHttpDataManager.h"

NSString *const kTPHttpEnvServerUrlKey = @"ServerUrl";

@implementation TPCustomTask

+ (instancetype)taskWithURL:(NSString *)url {
    return [[self alloc] initWithRequestURL:[NSURL URLWithString:url]];
}

+ (instancetype)taskWithAPI:(NSString *)url {
    NSString *urlStr = [[TPNetworkEnv defaultEnv] envValueForKey:kTPHttpEnvServerUrlKey];
    return [self taskWithURL:[NSString stringWithFormat:@"%@%@", urlStr, url]];
}

- (RACSignal *)get {
    return [[TPHttpDataManager shareManager] rac_getTask:self];
}
- (RACSignal *)post {
    return [[TPHttpDataManager shareManager] rac_postTask:self];
}
@end
