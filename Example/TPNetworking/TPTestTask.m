//
//  TPTestTask.m
//  TPNetwork_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPTestTask.h"

@implementation TPTestTask
+ (instancetype)task {
    TPTestTask *task = [TPTestTask taskWithURL:@"https://api.xuetian.cn/api/system/appinit"];
    return task;
}
@end
