//
//  TPPerson.h
//  TPNetworking_Example
//
//  Created by Topredator on 2020/10/29.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TPJsonModel/TPJsonModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface TPPerson : NSObject <TPJsonModel>
@property (nonatomic, copy) NSString *req_token;
@property (nonatomic, copy) NSString *url;
+ (instancetype)share;
+ (instancetype)url:(NSString *)url;
@end

@interface TPStudent : TPPerson
@property (nonatomic, copy) NSString *req_name;
@end

NS_ASSUME_NONNULL_END
