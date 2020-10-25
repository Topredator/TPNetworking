//
//  TPBaseDataTask.m
//  TPNetworking_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPBaseDataTask.h"

@implementation TPBaseDataTask
+ (instancetype)fetchTask:(NSString *)token {
    if (!token.length) return nil;
    id task = [[NSUserDefaults standardUserDefaults] valueForKey:[self fetchTokenKey:token]];
    
    if (task) return [NSKeyedUnarchiver unarchiveObjectWithData:task];
    return nil;
}
- (void)saveTask {
    if (!self.req_token.length) return;
    [self archiveTask];
    TPBaseDataTask *task = [[self class] unarchiveTask];
    if (!task) return;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:task];
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:[[self class] fetchTokenKey:self.req_token]];
}
+ (NSString *)fetchTokenKey:(NSString *)token {
    return [NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), token];
}
@end
