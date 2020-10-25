//
//  TPUserTask.m
//  TPNetworking_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPUserTask.h"

@implementation TPUserTask
+ (instancetype)task {
    TPUserTask *task = [TPUserTask taskWithURL:@"https://api.xuetian.cn/api/system/appinit"];
    return task;
}

- (void)setHTTPResponseObjectAfterSerialization:(id)responseObject error:(NSError *__autoreleasing *)error {
    self.dic = responseObject[@"value"];
}

@end
