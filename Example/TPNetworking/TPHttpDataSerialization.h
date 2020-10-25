//
//  TPHttpDataSerialization.h
//  TPNetwork_Example
//
//  Created by Topredator on 2020/10/25.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TPNetworking/NSError+TPNetworkError.h>
#import <TPNetworking/TPHttpSerialization.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPHTTPDataRequestSerializer : AFJSONRequestSerializer<TPHTTPRequestSerialization>

@end

@interface TPHTTPDataResponseSerializer : AFJSONResponseSerializer<TPHTTPResponseSerialization>

@end

@interface TPHttpDataErrorSerializer : TPHTTPErrorSerializer

@end
NS_ASSUME_NONNULL_END
