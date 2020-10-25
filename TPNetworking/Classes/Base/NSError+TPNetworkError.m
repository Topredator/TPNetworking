//
//  NSError+TPNetworkError.m
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "NSError+TPNetworkError.h"

NSErrorDomain const TPHTTPRequestSerializationDomain = @"com.tpnetwork.error.request.serialization";
NSErrorDomain const TPHTTPResponseSerializationDomain = @"com.tpnetwork.error.response.serialization";
NSErrorDomain const TPHTTPResponseUnderlyingDomain = @"com.tpnetwork.error.response.underlying";

@implementation NSError (TPNetworkError)
- (BOOL)isNetworkError {
    return [self.domain isEqualToString:NSURLErrorDomain];
}
- (BOOL)isRequestSerializationError {
    return [self.domain isEqualToString:TPHTTPRequestSerializationDomain];
}
- (BOOL)isResponseSerializationError {
    return [self.domain isEqualToString:TPHTTPResponseSerializationDomain];
}
- (BOOL)isResponseUnderlyingError {
    return [self.domain isEqualToString:TPHTTPResponseUnderlyingDomain];
}

- (NSError *)setDomain:(NSString *)domain {
    return [NSError errorWithDomain:domain code:self.code userInfo:self.userInfo];
}

- (NSError *)setUserInfo:(NSDictionary *)userInfo {
    return [NSError errorWithDomain:self.domain code:self.code userInfo:userInfo];
}
- (NSError *)setUserInfoObject:(id)object forKey:(id<NSCopying>)key {
    NSMutableDictionary *infoDic = self.userInfo ? self.userInfo.mutableCopy : [NSMutableDictionary dictionary];
    [infoDic setObject:object forKey:key];
    return [NSError errorWithDomain:self.domain code:self.code userInfo:infoDic.copy];
}
@end
