//
//  PayViewController.m
//  易购超市
//
//  Created by vison on 2017/5/14.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *orderArray;
    UITableView *payWayTabelView;
    NSArray *payWayArray;
    NSArray *payWayLabelArray;
    NSArray *colorArray;
    UIAlertController *alertController;
}

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付方式";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    __weak typeof(self.view) weakSelf = self.view;
    payWayArray = [NSArray array];
    payWayArray = @[@"货到付款",@"微信",@"银行卡",@"QQ钱包",@"信用卡",@"支付宝"];
    payWayLabelArray = [NSArray array];
    payWayLabelArray = @[@"货到付款",@"微信免密支付",@"一网通银行卡免密支付",@"QQ钱包免密支付",@"国际信用卡",@"支付宝免密支付"];
    colorArray = [NSArray array];
    colorArray = @[[UIColor colorWithRed:0.20 green:0.70 blue:0.49 alpha:1.00],
                   [UIColor colorWithRed:0.12 green:0.78 blue:0.14 alpha:1.00],
                   [UIColor colorWithRed:0.78 green:0.10 blue:0.20 alpha:1.00],
                   [UIColor colorWithRed:0.55 green:0.83 blue:0.98 alpha:1.00],
                   [UIColor colorWithRed:0.94 green:0.73 blue:0.35 alpha:1.00],
                   [UIColor colorWithRed:0.10 green:0.63 blue:0.90 alpha:1.00]];
    
    payWayTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [payWayTabelView registerClass:[UITableViewCell class]
                  forCellReuseIdentifier:@"payWayTableViewCell"];
    payWayTabelView.bounces = NO;
    payWayTabelView.backgroundColor = [UIColor whiteColor];
    payWayTabelView.showsVerticalScrollIndicator = NO;
    payWayTabelView.separatorStyle = NO;
    payWayTabelView.dataSource = self;
    payWayTabelView.delegate = self;
    [self.view addSubview:payWayTabelView];
    [payWayTabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(64);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf);
    }];

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return payWayArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payWayTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *cellView = [[UIView alloc] init];
    cellView.layer.cornerRadius = 5;
    cellView.backgroundColor = colorArray[indexPath.row];
    [cell addSubview:cellView];
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell).with.offset(10);
        make.left.equalTo(cell).with.offset(10);
        make.right.equalTo(cell).with.offset(-10);
        make.bottom.equalTo(cell);
    }];
    
    UILabel *payWayLabel = [[UILabel alloc] init];
    payWayLabel.backgroundColor = [UIColor clearColor];
    payWayLabel.text = payWayLabelArray[indexPath.row];
    payWayLabel.textColor = [UIColor whiteColor];
    payWayLabel.font = [UIFont systemFontOfSize:14];
    [cellView addSubview:payWayLabel];
    [payWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellView).with.offset(10);
        make.left.equalTo(cellView).with.offset(20);
        make.right.equalTo(cellView).with.offset(-10);
        make.height.equalTo(@20);
    }];
    
    UIView *payWayView = [[UIView alloc] init];
    payWayView.backgroundColor = [UIColor whiteColor];
    payWayView.layer.cornerRadius = 3;
    [cellView addSubview:payWayView];
    [payWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellView).with.offset(20);
        make.bottom.equalTo(cellView).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];

    
    UIImageView *payWayImageView = [[UIImageView alloc] init];
    payWayImageView.image = [UIImage imageNamed:payWayArray[indexPath.row]];
    [payWayView addSubview:payWayImageView];
    [payWayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(payWayView).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    UIButton *arrowsButton = [[UIButton alloc] init];
    arrowsButton.backgroundColor = [UIColor clearColor];
    [arrowsButton setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    [cellView addSubview:arrowsButton];
    [arrowsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cellView);
        make.right.equalTo(cellView.mas_right).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[User shared].address isEqualToString:@""]) {
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先设置收货地址！" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认订单！" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取当前时间
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
            NSString *dateTime = [formatter stringFromDate:date];
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];     //网络请求数据
            for(NSDictionary *good in orderArray) {
                NSString *urlStr = [NSString stringWithFormat:@"http://localhost/Order/admin.php?action=post&goodID=%@&userID=%@&num=%@&time=%@",[good valueForKey:@"ID"],[User shared].ID,[good valueForKey:@"num"],dateTime];
                [manager GET:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                     }];
                
                [manager GET:[NSString stringWithFormat:@"http://localhost/ShoppingCart/admin.php?action=delete&id=%@",[good valueForKey:@"ID"]] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         NSLog(@"Error: %@",error);
                     }];
                
            }
            
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
 
}


- (void)transferDataWith:(NSMutableArray *)array {
    orderArray = [NSMutableArray array];
    orderArray = array;
}


@end
