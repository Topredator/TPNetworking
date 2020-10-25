//
//  TPHttpSerialization.m
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPHttpSerialization.h"
#import "NSError+TPNetworkError.h"
@implementation TPHTTPErrorSerializer
@synthesize delegate = _delegate;

+ (instancetype)serializer {
    return [[self alloc] init];
}
#pragma mark ==================  TPHTTPErrorSerialization   ==================
- (NSError *)decodeHTTPError:(NSError *)error task:(__kindof TPHttpTask *)task {
    if ([error.domain isEqualToString:AFURLRequestSerializationErrorDomain]) {
        [error setDomain:TPHTTPRequestSerializationDomain];
    } else if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
        [error setDomain:TPHTTPResponseSerializationDomain];
    }
    return error;
}

@end

