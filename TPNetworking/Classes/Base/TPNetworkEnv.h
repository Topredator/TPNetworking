//
//  TPNetworkEnv.h
//  TPNetwork
//
//  Created by Topredator on 2020/10/25.
//

#import <Foundation/Foundation.h>


/// 网络环境配置类 （可用于本地plist文件对网络进行切换）
@interface TPNetworkEnv : NSObject
/// 当前的网络环境，可用于KVO
@property (nonatomic, copy, readonly) NSString *envName;

+ (instancetype)defaultEnv;
/**
 设置一个网络环境
 @param env 网络环境配置信息
 @param name 网络环境的名称
 */
- (void)setEnv:(NSDictionary *)env forName:(NSString *)name;

/**
 根据配置文件设置网络环境
 @param filePath 配置文件的路径
 */
- (void)setEnvsByConfigFile:(NSString *)filePath;

/**
 切换网络环境
 @param envname 网络环境的名称
 */
- (void)useEnvByName:(NSString *)envname;

/**
 获取当前环境变量
 @param key 环境变量名
 @return 环境变量的值
 */
- (id)envValueForKey:(NSString *)key;


/**
 更新环境

 @param dic 手动添加的环境
 */
- (void)updateEnvsWithDict:(NSDictionary *)dic;
/**
 获取所有网络环境
 */
- (NSDictionary *)allEnvs;
@end
