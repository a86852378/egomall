//
//  ClassesViewController.m
//  易购超市
//
//  Created by vison on 2017/4/30.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "ClassesViewController.h"
#import "GoodsTableView.h"
#import "DetailsViewController.h"

@interface ClassesViewController() <GoodsTableViewDelegate>{
    NSMutableArray *goodsArray;
}
@end


@implementation ClassesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"易购超市";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    goodsArray = [NSMutableArray array];
    if([_categoryStr isEqualToString:@"全部"]){
        goodsArray = _dataArray;
    }
    else{
        for(NSInteger i = 0 ; i < [_dataArray count] ; i ++){
            if([[[_dataArray objectAtIndex:i] valueForKey:@"type"] isEqualToString:_categoryStr]) {
                [goodsArray addObject:[_dataArray objectAtIndex:i]];
            }
        }
    }
    self.automaticallyAdjustsScrollViewInsets = NO;     //去除导航栏对布局的影响
    GoodsTableView *goodsTableView = [[GoodsTableView alloc] initWithFrame:CGRectMake(0, HEIGHT_STATUSBAR + HEIGHT_NAVBAR, SCREEN_WIDTH, SCREEN_HEIGHT - HEIGHT_STATUSBAR - HEIGHT_NAVBAR) style:UITableViewStylePlain];
    [goodsTableView transferDataWith:goodsArray];
    goodsTableView.deleGate = self;
    [self.view addSubview:goodsTableView];
    // Do any additional setup after loading the view.
}

- (void)goodsClickActionAbout:(NSDictionary *)goodDic {
    DetailsViewController *detailViewController = [[DetailsViewController alloc] init];
    //自定义返回按钮
//    detailViewController.view.backgroundColor = [UIColor whiteColor];
    detailViewController.goodDic = goodDic;
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backBar];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
