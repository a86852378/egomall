//
//  DataArray.h
//  易购超市
//
//  Created by vison on 2017/5/28.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataArray : NSObject

@property(nonatomic,strong) NSMutableArray *allDataArray;

+ (instancetype)shared;

@end
