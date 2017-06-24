//
//  GoodsTableView.m
//  易购超市
//
//  Created by vison on 2017/4/30.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "GoodsTableView.h"
#import "GoodsTableViewCell.h"

@interface GoodsTableView()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *goodsArray;
}

@end

@implementation GoodsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        goodsArray = [NSMutableArray array];
        
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[GoodsTableViewCell class] forCellReuseIdentifier:@"goodsTableViewCell"];//注册cell
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (void)transferDataWith:(NSMutableArray *)array{
    goodsArray = array;
}

#pragma tableView delegate && dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return goodsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsTableViewCell" forIndexPath:indexPath];
    [cell getName:[[goodsArray objectAtIndex:indexPath.row] valueForKey:@"name"]];
    [cell getPrice:[[goodsArray objectAtIndex:indexPath.row] valueForKey:@"price"]];
    [cell getSales:[[goodsArray objectAtIndex:indexPath.row] valueForKey:@"sales"]];
    [cell getImage:[[goodsArray objectAtIndex:indexPath.row] valueForKey:@"image"]];
    [cell getID:[[goodsArray objectAtIndex:indexPath.row] valueForKey:@"ID"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.deleGate && [self.deleGate respondsToSelector:@selector(goodsClickActionAbout:)]){
        [self.deleGate goodsClickActionAbout:[goodsArray objectAtIndex:indexPath.row]];
    }
}

@end
