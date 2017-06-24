//
//  Good.m
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "Good.h"

@implementation Good

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ID = @"";
        self.name = @"";
        self.price = 0;
        self.sales = 0;
        self.image = @"";
        self.type = @"";
        self.num = 0;
    }
    return self;
}

//将数据制成model
- (NSMutableArray *)makeItGoodArrayWith:(NSMutableArray *)dataArr {
    NSMutableArray *modelArr = [NSMutableArray array];
    for(NSInteger i = 0 ; i < [dataArr count] ; i ++) {
        Good *model = [[Good alloc] init];
        model.ID = [[dataArr objectAtIndex:i] valueForKey:@"id"];
        model.name = [[dataArr objectAtIndex:i] valueForKey:@"name"];
        model.price = [[dataArr objectAtIndex:i] valueForKey:@"price"];
        model.sales = [[dataArr objectAtIndex:i] valueForKey:@"sales"];
        model.image = [[dataArr objectAtIndex:i] valueForKey:@"image"];
        model.type = [[dataArr objectAtIndex:i] valueForKey:@"type"];
        model.num = [[dataArr objectAtIndex:i] valueForKey:@"num"];
        [modelArr addObject:model];
    }
    return modelArr;
}

@end
