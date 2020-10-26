//
//  TPHttpDataTask.m
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPHttpDataTask.h"

@implementation TPHttpDataTask
+ (instancetype)unarchiveTask {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
}

+ (NSString *)archivePath {
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *dir = [cache stringByAppendingPathComponent:@"com.tpnetwork.task"];
    return [dir stringByAppendingPathComponent:NSStringFromClass(self)];
}

- (void)archiveTask {
    NSString *path = [[self class] archivePath];
    NSString *dir = [path stringByDeletingLastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [NSKeyedArchiver archiveRootObject:self toFile:path];
}

- (RACSignal *)get {
    @throw [NSException exceptionWithName:@"need to overwrite get method" reason:@"由于服务器对《请求参数加密》及 《响应处理》方式有业务决定，子类需要重新get 方法" userInfo:nil];
//    return nil;
}
- (RACSignal *)post {
    @throw [NSException exceptionWithName:@"need to overwrite post method" reason:@"由于服务器对《请求参数加密》及 《响应处理》方式有业务决定，子类需要重新get 方法" userInfo:nil];
}
#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    return [self tp_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    return [self tp_modelInitWithCoder:aDecoder];
}
/// 黑名单
+ (NSArray<NSString *> *)tp_modelPropertyBlacklist {
    return @[@"requestURL", @"networkError", @"sessionTask", @"formDataMaker"];
}
/// 识别request属性的前缀
+ (NSString *)tp_prefixForModelWriteableProerties {
    return @"req_";
}
@end
