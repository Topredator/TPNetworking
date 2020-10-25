//
//  TPHttpDataManager.h
//  TPNetwork_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import <TPNetworking/TPNetworking.h>
#import "TPHttpDataSerialization.h"

NS_ASSUME_NONNULL_BEGIN

@interface TPHttpDataManager : TPHttpManager
@property (nonatomic, strong) TPHTTPDataRequestSerializer *requestSerializer;
@property (nonatomic, strong) TPHTTPDataResponseSerializer *responseSerializer;
@property (nonatomic, strong) TPHttpDataErrorSerializer *errorSerializer;

+ (instancetype)shareManager;
@end

NS_ASSUME_NONNULL_END
