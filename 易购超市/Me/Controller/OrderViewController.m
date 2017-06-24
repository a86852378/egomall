//
//  OrderViewController.m
//  易购超市
//
//  Created by vison on 2017/5/14.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "OrderViewController.h"
#import "Good.h"
#import "DataArray.h"

@interface OrderViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UILabel *addressLabel;
    UITableView *orderTableView;
    NSMutableArray *orderArray;
}

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self.view) weakSelf = self.view;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的订单";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    orderArray = [NSMutableArray array];
    
    addressLabel = [[UILabel alloc] init];
    addressLabel.text = [NSString stringWithFormat:@"收货地址：%@",[User shared].address];
    addressLabel.font = [UIFont systemFontOfSize:14];
    
    orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [orderTableView registerClass:[UITableViewCell class]
                  forCellReuseIdentifier:@"shoppingCartTableViewCell"];
    orderTableView.bounces = NO;
    orderTableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    orderTableView.showsVerticalScrollIndicator = NO;
    orderTableView.separatorStyle = NO;
    orderTableView.dataSource = self;
    orderTableView.delegate = self;

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];     //网络请求数据
    [manager GET:[NSString stringWithFormat:@"http://localhost/Order/admin.php?action=get&userID=%@",[User shared].ID]
        parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if([[responseObject valueForKey:@"flag"] isEqualToString:@"1"]){
                orderArray = [responseObject valueForKey:@"data"];
                [self.view addSubview:addressLabel];
                [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakSelf).with.offset(64);
                    make.left.equalTo(weakSelf).with.offset(10);
                    make.right.equalTo(weakSelf).with.offset(10);
                    make.height.equalTo(@50);
                }];
                
                [self.view addSubview:orderTableView];
                [orderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(addressLabel.mas_bottom);
                    make.left.equalTo(weakSelf);
                    make.right.equalTo(weakSelf);
                    make.bottom.equalTo(weakSelf);
                }];
            }
            else {
                UILabel *failureLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, SCREEN_HEIGHT/2 - 50, 200, 20)];
                failureLabel.text = @"您还没有任何订单";
                failureLabel.font = [UIFont systemFontOfSize:15];
                failureLabel.textAlignment = NSTextAlignmentCenter;
                failureLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
                [self.view addSubview:failureLabel];
            }
        }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSLog(@"Error: %@",error);
             }];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return orderArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCartTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *good = [NSDictionary dictionary];
    for (NSDictionary *dic in [DataArray shared].allDataArray) {
        if ([[dic valueForKey:@"ID"] isEqualToString:[[orderArray objectAtIndex:indexPath.row] valueForKey:@"good_id"]]) {
            good = dic;
        }
    }
    
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 95)];
    cellView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:cellView];
    
    UIImageView *goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 60, 60)];
    NSError *error;
    NSString *urlStr = [good valueForKey:@"image"];
    NSURL *url =  [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    UIImage *image = [UIImage imageWithData:data];
    goodsImageView.image = image;
    [cellView addSubview:goodsImageView];
    
    UILabel *goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH - 120, 30)];
    goodsNameLabel.text = [good valueForKey:@"name"];
    goodsNameLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    goodsNameLabel.font = [UIFont systemFontOfSize:14];
    [cellView addSubview:goodsNameLabel];
    
    UILabel *goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 45, 100, 25)];
    goodsPriceLabel.text = [NSString stringWithFormat:@"¥ %@",[good valueForKey:@"price"]];
    goodsPriceLabel.textColor = [UIColor redColor];
    goodsPriceLabel.font = [UIFont systemFontOfSize:14];
    [cellView addSubview:goodsPriceLabel];
    
    UILabel *goodsNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 50, 50, 20)];
    goodsNumLabel.text = [NSString stringWithFormat:@"x%@",[[orderArray objectAtIndex:indexPath.row] valueForKey:@"num"]];;
    goodsNumLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    goodsNumLabel.font = [UIFont systemFontOfSize:12];
    goodsNumLabel.textAlignment = NSTextAlignmentRight;
    [cellView addSubview:goodsNumLabel];
    
    UIView *cellLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 0.5)];
    cellLineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [cellView addSubview:cellLineView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 150, 15)];
    timeLabel.text = [[orderArray objectAtIndex:indexPath.row] valueForKey:@"time"];
    timeLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    timeLabel.font = [UIFont systemFontOfSize:11];
    [cellView addSubview:timeLabel];
     
    UILabel *xiaojiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 80, 35, 15)];
    xiaojiLabel.text = @"合计：";
    xiaojiLabel.font = [UIFont systemFontOfSize:11];
    xiaojiLabel.textAlignment = NSTextAlignmentRight;
    [cellView addSubview:xiaojiLabel];
    
    UILabel *singleSumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, 80, 45, 15)];
    NSNumber *price = [good valueForKey:@"price"];
    NSNumber *num = [[orderArray objectAtIndex:indexPath.row] valueForKey:@"num"];
    NSNumber *singleSum = [NSNumber numberWithFloat:[price floatValue] * [num intValue]];
    singleSumLabel.text = [NSString stringWithFormat:@"¥ %@",singleSum];
    singleSumLabel.textColor = [UIColor redColor];
    singleSumLabel.font = [UIFont systemFontOfSize:11];
    singleSumLabel.textAlignment = NSTextAlignmentRight;
    [cellView addSubview:singleSumLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
