//
//  TPHttpTask.m
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPHttpTask.h"
#import "TPNetworkPrivate.h"

@implementation TPHttpTask
+ (instancetype)task {
    return [[self alloc] initWithRequestURL:nil];
}
- (instancetype)init {
    return [self initWithRequestURL:nil];
}
- (instancetype)initWithRequestURL:(NSURL *)url {
    self = [super init];
    if (self) {
        self.requestURL = url;
        self.logLevel = DDLogLevelAll;
    }
    return self;
}
- (void)cancelTask {
    [self.sessionTask cancel];
}
- (void)fetchSimulateResponseObjectWithCompleted:(void (^)(id, NSError *))completed {
    completed(nil, nil);
}


#pragma mark ==================  NSCoding   ==================
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.requestURL forKey:@"requestURL"];
    [aCoder encodeObject:self.networkError forKey:@"networkError"];
    [aCoder encodeObject:self.sessionTask forKey:@"sessionTask"];
    [aCoder encodeBool:self.simulateResponse forKey:@"simulateResponse"];
    [aCoder encodeObject:self.serverTotalResponseData forKey:@"serverTotalResponseData"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.requestURL = [aDecoder decodeObjectForKey:@"requestURL"];
        self.networkError = [aDecoder decodeObjectForKey:@"networkError"];
        self.sessionTask = [aDecoder decodeObjectForKey:@"sessionTask"];
        self.simulateResponse = [aDecoder decodeBoolForKey:@"simulateResponse"];
        self.serverTotalResponseData = [aDecoder decodeObjectForKey:@"serverTotalResponseData"];
    }
    return self;
}
#pragma mark ==================  NSCopying   ==================
- (id)copyWithZone:(NSZone *)zone {
    TPHttpTask *task = [[self class] allocWithZone:zone];
    task.requestURL = self.requestURL;
    task.networkError = self.networkError;
    task.sessionTask = self.sessionTask;
    task.simulateResponse = self.simulateResponse;
    task.serverTotalResponseData = self.serverTotalResponseData;
    return task;
}
@end
