//
//  DetailsViewController.m
//  易购超市
//
//  Created by vison on 2017/5/3.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsView.h"
#import "ShoppingCartViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    __weak typeof(self.view) weakSelf = self.view;
    //底部按钮条
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [bottomView addSubview:lineView];
    
    UIButton *shoppingCartButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, 10, 38, 38)];
    [shoppingCartButton setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
    [shoppingCartButton addTarget:self action:@selector(shoppingCartButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:shoppingCartButton];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    addButton.frame = CGRectMake(SCREEN_WIDTH - 160, 0, 80, 55);
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [addButton addTarget:self action:@selector(addShoppingCarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    addButton.backgroundColor = [UIColor redColor];
    [bottomView addSubview:addButton];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    buyButton.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 80, 55);
    buyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [buyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    buyButton.backgroundColor = [UIColor orangeColor];
    [bottomView addSubview:buyButton];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(@55);
    }];
    
    //商品详情
    self.automaticallyAdjustsScrollViewInsets = NO;     //去除导航栏对布局的影响
    UICollectionViewFlowLayout *detailsFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [detailsFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    DetailsView *detailsView = [[DetailsView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 55)];
    [detailsView transferDataWith:_goodDic];
    [self.view addSubview:detailsView];
    
    
}

- (void)shoppingCartButtonAction {
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backBar];
    [self.navigationController pushViewController:[[ShoppingCartViewController alloc] init] animated:YES];
}

- (void)addShoppingCarButtonClick {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];     //网络请求数据
    [manager GET:[NSString stringWithFormat:@"http://localhost/ShoppingCart/admin.php?action=update&id=%@",[_goodDic valueForKey:@"ID"]] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@",error);
         }];
}

- (void)buyButtonClick {
    [self addShoppingCarButtonClick];
    [self shoppingCartButtonAction];
}


@end
