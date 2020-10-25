//
//  TPBaseDataTask.h
//  TPNetworking_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import <TPNetworking/TPNetworking.h>
#import "TPCustomTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPBaseDataTask : TPCustomTask
@property (nonatomic, copy) NSString *req_token;
+ (instancetype)fetchTask:(NSString *)token;
- (void)saveTask;
@end

NS_ASSUME_NONNULL_END
