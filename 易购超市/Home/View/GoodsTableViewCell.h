//
//  GoodsTableViewCell.h
//  易购超市
//
//  Created by vison on 2017/4/30.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTableViewCell : UITableViewCell

- (void)getName:(NSString *)name;

- (void)getPrice:(NSString *)price;

- (void)getSales:(NSString *)sales;

- (void)getImage:(NSString *)imageStr;

- (void)getID:(NSString *)ID;
@end
