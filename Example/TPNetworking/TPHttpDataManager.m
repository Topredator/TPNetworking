//
//  TPHttpDataManager.m
//  TPNetwork_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPHttpDataManager.h"

@implementation TPHttpDataManager
@dynamic requestSerializer, responseSerializer, errorSerializer;
+ (instancetype)shareManager {
    static TPHttpDataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [self manager];
        dataManager.requestSerializer = [TPHTTPDataRequestSerializer serializer];
        dataManager.responseSerializer = [TPHTTPDataResponseSerializer serializer];
        dataManager.errorSerializer = [TPHttpDataErrorSerializer serializer];
    });
    return dataManager;
}
@end
