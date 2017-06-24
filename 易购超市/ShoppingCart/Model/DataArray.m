//
//  DataArray.m
//  易购超市
//
//  Created by vison on 2017/5/28.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "DataArray.h"

@implementation DataArray

+ (instancetype)shared {
    static DataArray *dataArray;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataArray = [[DataArray alloc] init];
    });
    return dataArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.allDataArray = [NSMutableArray array];
    }
    return self;
}

@end
