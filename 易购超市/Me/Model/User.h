//
//  User.h
//  易购超市
//
//  Created by vison on 2017/5/8.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phoneNumber;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *address;

+ (instancetype)shared;

@end
