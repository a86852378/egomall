//
//  User.m
//  易购超市
//
//  Created by vison on 2017/5/8.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "User.h"

@implementation User

+ (instancetype)shared {
    static User *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    return user;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ID = @"";
        self.name = @"";
        self.phoneNumber = @"";
        self.password = @"";
        self.address = @"";
    }
    return self;
}

@end
