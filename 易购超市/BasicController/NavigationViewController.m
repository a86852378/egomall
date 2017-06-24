//
//  NavigationViewController.m
//  易购超市
//
//  Created by vison on 2017/6/23.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.94 green:0.60 blue:0.15 alpha:1.00];
    self.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
