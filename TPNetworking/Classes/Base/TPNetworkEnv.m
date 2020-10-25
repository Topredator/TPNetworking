//
//  TPNetworkEnv.m
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import "TPNetworkEnv.h"

NSString *const kTPHTTPEnvNameLocalKey = @"com.tpnetwork.local.env.name";

@interface TPNetworkEnv ()
/// 存储所有环境
@property (nonatomic, strong) NSMutableDictionary *envs;
@end

@implementation TPNetworkEnv
@synthesize envName = _envName;
+ (instancetype)defaultEnv {
    static TPNetworkEnv *staticEnv;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        staticEnv = [[TPNetworkEnv alloc] init];
    });
    return staticEnv;
}
- (void)setEnv:(NSDictionary *)env forName:(NSString *)name {
    if (!env || !name.length) return;
    [self.envs setObject:env forKey:name];
    if (!self.envName) {
        _envName = name;
    }
}
- (void)setEnvsByConfigFile:(NSString *)filePath {
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if (!config) return;
    [self.envs addEntriesFromDictionary:config];
}
- (void)useEnvByName:(NSString *)envname {
    [self willChangeValueForKey:@"envName"];
    _envName = envname;
    NSDictionary *env = self.allEnvs[envname];
    if (env) {
        [[NSUserDefaults standardUserDefaults] setObject:envname forKey:kTPHTTPEnvNameLocalKey];
    }
    [self didChangeValueForKey:@"envName"];
}
- (id)envValueForKey:(NSString *)key {
    if (!self.envName) return nil;
    NSDictionary *env = self.allEnvs[self.envName];
    return env[key];
}

- (void)updateEnvsWithDict:(NSDictionary *)dic
{
    if (dic) {
        [self.envs addEntriesFromDictionary:dic];
    }
}

- (NSDictionary *)allEnvs {
    return [self.envs copy];
}
#pragma mark ================== lazy method  ==================
- (NSMutableDictionary *)envs {
    if (!_envs) {
        _envs = [NSMutableDictionary dictionary];
    }
    return _envs;
}
- (NSString *)envName {
    if (!_envName) {
        _envName = [[NSUserDefaults standardUserDefaults] objectForKey:kTPHTTPEnvNameLocalKey];
    }
    return _envName;
}
@end
