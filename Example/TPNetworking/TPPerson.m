//
//  TPPerson.m
//  TPNetworking_Example
//
//  Created by Topredator on 2020/10/29.
//  Copyright © 2020 Topredator. All rights reserved.
//

#import "TPPerson.h"

@implementation TPPerson
+ (instancetype)share {
    TPPerson *person = [self new];
    return person;
}
+ (instancetype)url:(NSString *)url {
    TPPerson *person = [self share];
    person.req_token = @"1111";
    person.url = url;
    return person;
}
+ (NSString *)tp_prefixForModelWriteableProerties {
    return @"req_";
}
@end

@implementation TPStudent

@end
