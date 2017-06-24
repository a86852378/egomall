//
//  Good.h
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSNumber *price;
@property(nonatomic,copy) NSNumber *sales;
@property(nonatomic,copy) NSString *image;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,assign) NSNumber *num;

- (NSMutableArray *)makeItGoodArrayWith:(NSMutableArray *)dataArr;

@end
