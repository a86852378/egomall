//
//  CategoryCollectionView.h
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryCollectionDelegate <NSObject>

- (void)categoryClickActionAbout:(NSString *)categoryStr;

@end

@interface CategoryCollectionView : UICollectionView

@property(nonatomic,weak) id <CategoryCollectionDelegate> deleGate;

@end
