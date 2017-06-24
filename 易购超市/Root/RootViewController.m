//
//  RootViewController.m
//  易购超市
//
//  Created by vison on 2017/6/22.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationViewController.h"
#import "HomeViewController.h"
#import "ShoppingCartViewController.h"
#import "MeViewController.h"

@interface RootViewController ()

@property (strong, nonatomic) HomeViewController *homeVC;
@property (strong, nonatomic) ShoppingCartViewController *shoppingCartVC;
@property (strong, nonatomic) MeViewController *meVC;
@property (strong, nonatomic) NSArray *childVCArray;

@end

static RootViewController *rootVC = nil;

@implementation RootViewController

+ (RootViewController *)shareRootViewController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rootVC = [[self alloc] init];
    });
    return rootVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewControllers:self.childVCArray];
}


#pragma mark - Getter

- (NSArray *)childVCArray {
    if (_childVCArray == nil) {
        _childVCArray = [[NSArray alloc]init];
        NavigationViewController *homeNavVC = [[NavigationViewController alloc] initWithRootViewController:self.homeVC];
        NavigationViewController *shoppingCartNavVC = [[NavigationViewController alloc] initWithRootViewController:self.shoppingCartVC];
        NavigationViewController *meNavVC = [[NavigationViewController alloc] initWithRootViewController:self.meVC];
        _childVCArray = @[homeNavVC,shoppingCartNavVC,meNavVC];
    }
    return _childVCArray;
}

- (HomeViewController *)homeVC {
    if (_homeVC == nil) {
        _homeVC = [[HomeViewController alloc]init];
        [_homeVC setTitle:@"首页"];
        [_homeVC.tabBarItem setImage:[UIImage imageNamed:@"首页_normal"]];
        [_homeVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"首页_selected"]];
    }
    return _homeVC;
}

- (ShoppingCartViewController *)shoppingCartVC {
    if (_shoppingCartVC == nil) {
        _shoppingCartVC = [[ShoppingCartViewController alloc]init];
        [_shoppingCartVC setTitle:@"购物车"];
        [_shoppingCartVC.tabBarItem setImage:[UIImage imageNamed:@"购物车_normal"]];
        [_shoppingCartVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"购物车_selected"]];
        
    }
    return _shoppingCartVC;
}

- (MeViewController *)meVC {
    if (_meVC == nil) {
        _meVC = [[MeViewController alloc]init];
        [_meVC setTitle:@"我的"];
        [_meVC.tabBarItem setImage:[UIImage imageNamed:@"我的_normal"]];
        [_meVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"我的_selected"]];
    }
    
    return _meVC;
}



@end
