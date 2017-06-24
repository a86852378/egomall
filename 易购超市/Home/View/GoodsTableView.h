//
//  GoodsTableView.h
//  易购超市
//
//  Created by vison on 2017/4/30.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsTableViewDelegate <NSObject>

- (void)goodsClickActionAbout:(NSDictionary *)goodDic;

@end

@interface GoodsTableView : UITableView

@property(nonatomic,weak) id <GoodsTableViewDelegate> deleGate;

- (void)transferDataWith:(NSMutableArray *)array;

@end
