//
//  MainView.h
//  易购超市
//
//  Created by vison on 2017/4/30.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainViewDelegate <NSObject>

- (void)passCategoryClickActionAbout:(NSString *)categoryStr;

- (void)passGoodsClickActionAbout:(NSDictionary *)goodDic;

- (void)passCountDownClickActionAbout:(NSDictionary *)goodDic;
@end

@interface MainView : UICollectionView

@property(nonatomic,weak) id <MainViewDelegate> deleGate;

- (void)transferDataWith:(NSMutableArray *)array;

@end
