//
//  TPNetworkPrivate.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

/********************* JSON操作 ***************************/
#define TPNetworkJSONData(obj)  [NSJSONSerialization dataWithJSONObject:(obj) options:NSJSONWritingPrettyPrinted error:nil]
#define TPNetworkJSONString(obj) [[NSString alloc] initWithData:TPNetworkJSONData(obj) encoding:NSUTF8StringEncoding]

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = DDLogLevelInfo;
#endif

#define TPLogError(level, frmt, ...)   \
LOG_MAYBE(NO, (level & LOG_LEVEL_DEF), DDLogFlagError, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define TPLogWarn(level, frmt, ...)    \
LOG_MAYBE(LOG_ASYNC_ENABLED, (level & LOG_LEVEL_DEF), DDLogFlagWarning, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define TPLogInfo(level, frmt, ...)    \
LOG_MAYBE(LOG_ASYNC_ENABLED, (level & LOG_LEVEL_DEF), DDLogFlagInfo, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define TPLogDebug(level, frmt, ...)   \
LOG_MAYBE(LOG_ASYNC_ENABLED, (level & LOG_LEVEL_DEF), DDLogFlagDebug, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)
#define TPLogVerbose(level, frmt, ...)        \
LOG_MAYBE(LOG_ASYNC_ENABLED, (level & LOG_LEVEL_DEF), DDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, ##__VA_ARGS__)


#import "TPHttpTask.h"

@interface TPHttpTask ()
@property (nonatomic, strong, readwrite) NSURL *requestURL;
@property (nonatomic, strong, readwrite) NSError *networkError;
@property (nonatomic, strong, readwrite) NSURLSessionDataTask *sessionTask;
@end

