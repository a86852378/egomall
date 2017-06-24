//
//  CountDownGoodView.h
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CountDownGoodViewDelegate <NSObject>

- (void)countDownClickActionAbout:(NSDictionary *)goodDic;

@end

@interface CountDownGoodView : UIView

@property(nonatomic,weak) id <CountDownGoodViewDelegate> deleGate;

@end
