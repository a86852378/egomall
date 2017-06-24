//
//  ShoppingCartViewController.m
//  易购超市
//
//  Created by vison on 2017/5/10.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "Good.h"
#import "PayViewController.h"

@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIView *bottomView;
    UIView *lineView;
    UIButton *allSelectButton;
    UILabel *allSelectLabel;
    UILabel *hejiLabel;
    UILabel *sumLabel;
    UIButton *accountButton;
    
    UITableView *shoppingCartTableView;
    NSMutableArray *dataArray;
    NSMutableArray *selectGoodsArray;
    NSMutableArray *selectButtonArray;
    NSMutableArray *selectedSumArray;
    NSNumber *selectedSum;
    NSInteger selectedNum;
}

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    __weak typeof(self.view) weakSelf = self.view;
    selectGoodsArray = [NSMutableArray array];
    selectButtonArray = [NSMutableArray array];
    selectedSumArray = [NSMutableArray array];
    
    //底部按钮条
    bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [bottomView addSubview:lineView];
    
    allSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allSelectButton.tag = 100;
    allSelectButton.layer.cornerRadius = 6;
    allSelectButton.layer.borderWidth = 0.5;
    allSelectButton.layer.borderColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    [allSelectButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [allSelectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:allSelectButton];
    
    allSelectLabel = [[UILabel alloc] init];
    allSelectLabel.text = @"全选";
    allSelectLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:allSelectLabel];
    
    hejiLabel = [[UILabel alloc] init];
    hejiLabel.text = @"合计：";
    hejiLabel.font = [UIFont systemFontOfSize:13];
    hejiLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:hejiLabel];
    
    sumLabel = [[UILabel alloc] init];
    sumLabel.text = @"¥ 0";
    sumLabel.textColor = [UIColor redColor];
    sumLabel.font = [UIFont systemFontOfSize:13];
    sumLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:sumLabel];
    
    accountButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [accountButton setTitle:@"结 算" forState:UIControlStateNormal];
    accountButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [accountButton addTarget:self action:@selector(accountButtonAction) forControlEvents:UIControlEventTouchUpInside];
    accountButton.backgroundColor = [UIColor orangeColor];
    [bottomView addSubview:accountButton];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-49);
        make.height.equalTo(@40);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.right.equalTo(bottomView);
        make.top.equalTo(bottomView);
        make.height.equalTo(@1);
    }];
    [allSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(10);
        make.top.equalTo(bottomView).with.offset(14);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [allSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allSelectButton.mas_right).with.offset(5);
        make.top.equalTo(bottomView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [hejiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sumLabel.mas_left);
        make.top.equalTo(bottomView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(accountButton.mas_left).with.offset(-10);
        make.top.equalTo(bottomView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [accountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.top.equalTo(bottomView);
        make.bottom.equalTo(bottomView);
        make.width.equalTo(@80);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    if(isLoged){
        __weak typeof(self.view) weakSelf = self.view;
        [selectButtonArray removeAllObjects];
        [selectedSumArray removeAllObjects];
        selectedSum = 0;
        selectedNum = 0;
        sumLabel.text = @"¥ 0";
        [shoppingCartTableView removeFromSuperview];
        allSelectButton.selected = NO;
        
        shoppingCartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        [shoppingCartTableView registerClass:[UITableViewCell class]
                      forCellReuseIdentifier:@"shoppingCartTableViewCell"];
        shoppingCartTableView.bounces = NO;
        shoppingCartTableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        shoppingCartTableView.showsVerticalScrollIndicator = NO;
        shoppingCartTableView.separatorStyle = NO;
        shoppingCartTableView.dataSource = self;
        shoppingCartTableView.delegate = self;
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];     //网络请求数据
        [manager GET:@"http://localhost/ShoppingCart/admin.php?action=get" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if([[responseObject valueForKey:@"flag"] isEqualToString:@"1"]){
                allSelectButton.enabled = YES;
                Good *good = [[Good alloc] init];
                dataArray = [good makeItGoodArrayWith:[responseObject valueForKey:@"data"]];
                [self.view addSubview:shoppingCartTableView];
                
                [shoppingCartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakSelf).with.offset(64);
                    make.left.equalTo(weakSelf);
                    make.right.equalTo(weakSelf);
                    make.bottom.equalTo(weakSelf).with.offset(-89);
                }];
            }
            else {
                allSelectButton.enabled = NO;
                UILabel *failureLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, self.view.frame.size.height/2 - 50, 200, 20)];
                failureLabel.text = @"您的购物车里空无一物";
                failureLabel.font = [UIFont systemFontOfSize:15];
                failureLabel.textAlignment = NSTextAlignmentCenter;
                failureLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
                [self.view addSubview:failureLabel];
            }
            [shoppingCartTableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@",error);
            UILabel *failureLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, self.view.frame.size.height/2 - 50, 200, 20)];
            failureLabel.text = @"无网络连接";
            failureLabel.textAlignment = NSTextAlignmentCenter;
            failureLabel.font = [UIFont systemFontOfSize:20];
            failureLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
            [self.view addSubview:failureLabel];
        }];
    }
    else{
        [shoppingCartTableView removeFromSuperview];
        UILabel *failureLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200)/2, self.view.frame.size.height/2 - 50, 200, 20)];
        failureLabel.text = @"请先登录账户";
        failureLabel.font = [UIFont systemFontOfSize:15];
        failureLabel.textAlignment = NSTextAlignmentCenter;
        failureLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
        [self.view addSubview:failureLabel];
    }
    
}

- (void)selectButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if(sender.tag == 100){
        selectedSum = 0;
        if(sender.selected == YES){
            selectGoodsArray = dataArray;
            selectedNum = selectButtonArray.count;
            for(NSNumber *num in selectedSumArray){
                selectedSum = [NSNumber numberWithFloat:[selectedSum floatValue] + [num floatValue]];
            }
            sumLabel.text = [NSString stringWithFormat:@"¥ %0.1f",[selectedSum floatValue]];
        }
        else{
            selectGoodsArray = [NSMutableArray array];
            selectedSumArray = [NSMutableArray array];
            selectedNum = 0;
            sumLabel.text = @"¥ 0";
        }
        for(UIButton *button in selectButtonArray){
            if(sender.selected == YES){
                button.selected = YES;
            }
            else{
                button.selected = NO;
            }
        }
    }
    else{
        if(sender.selected == YES){
            selectedNum ++;
            if(selectedNum == selectButtonArray.count){
                allSelectButton.selected = YES;
            }
            [selectGoodsArray addObject:[dataArray objectAtIndex:sender.tag]];
            selectedSum = [NSNumber numberWithFloat:[selectedSum floatValue] + [[selectedSumArray objectAtIndex:sender.tag] floatValue]];
            sumLabel.text = [NSString stringWithFormat:@"¥ %0.1f",[selectedSum floatValue]];
        }
        else{
            selectedNum --;
            allSelectButton.selected = NO;
            selectedSum = [NSNumber numberWithFloat:[selectedSum floatValue] - [[selectedSumArray objectAtIndex:sender.tag] floatValue]];
            sumLabel.text = [NSString stringWithFormat:@"¥ %0.1f",[selectedSum floatValue]];
            if(selectedNum == 0){
                sumLabel.text = @"¥ 0";
            }
        }
    }
}

- (void)accountButtonAction {
    if(selectedNum == 0){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请先选择商品" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backBar];
        PayViewController *vc = [[PayViewController alloc] init];
        [vc transferDataWith:selectGoodsArray];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCartTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 95)];
    cellView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:cellView];
    
    UIButton *selectButtton = [[UIButton alloc] initWithFrame:CGRectMake(8, 34, 12, 12)];
    selectButtton.tag = indexPath.row;
    selectButtton.layer.cornerRadius = 6;
    selectButtton.layer.borderWidth = 0.5;
    selectButtton.layer.borderColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    [selectButtton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [selectButtton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cellView addSubview:selectButtton];
    [selectButtonArray addObject:selectButtton];
    
    UIImageView *goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 60, 60)];
    NSError *error;
    NSString *urlStr = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"image"];
    NSURL *url =  [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    UIImage *image = [UIImage imageWithData:data];
    goodsImageView.image = image;
    [cellView addSubview:goodsImageView];
    
    UILabel *goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, SCREEN_WIDTH - 120, 30)];
    goodsNameLabel.text = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    goodsNameLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
    goodsNameLabel.font = [UIFont systemFontOfSize:14];
    [cellView addSubview:goodsNameLabel];
    
    UILabel *goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 45, 100, 25)];
    goodsPriceLabel.text = [NSString stringWithFormat:@"¥ %@",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"price"]];
    goodsPriceLabel.textColor = [UIColor redColor];
    goodsPriceLabel.font = [UIFont systemFontOfSize:14];
    [cellView addSubview:goodsPriceLabel];
    
    UILabel *goodsNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 50, 50, 20)];
    goodsNumLabel.text = [NSString stringWithFormat:@"x%@",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"num"]];;
    goodsNumLabel.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1];
    goodsNumLabel.font = [UIFont systemFontOfSize:12];
    goodsNumLabel.textAlignment = NSTextAlignmentRight;
    [cellView addSubview:goodsNumLabel];
    
    UIView *cellLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 0.5)];
    cellLineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [cellView addSubview:cellLineView];
    
    UILabel *xiaojiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 85, 80, 35, 15)];
    xiaojiLabel.text = @"小计：";
    xiaojiLabel.font = [UIFont systemFontOfSize:11];
    xiaojiLabel.textAlignment = NSTextAlignmentRight;
    [cellView addSubview:xiaojiLabel];
    
    UILabel *singleSumLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, 80, 45, 15)];
    NSNumber *price = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"price"];
    NSNumber *num = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"num"];
    NSNumber *singleSum = [NSNumber numberWithFloat:[price floatValue] * [num intValue]];
    singleSumLabel.text = [NSString stringWithFormat:@"¥ %@",singleSum];
    [selectedSumArray addObject:singleSum];
    singleSumLabel.textColor = [UIColor redColor];
    singleSumLabel.font = [UIFont systemFontOfSize:11];
    singleSumLabel.textAlignment = NSTextAlignmentRight;
    [cellView addSubview:singleSumLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];     //网络请求数据
    [manager GET:[NSString stringWithFormat:@"http://localhost/ShoppingCart/admin.php?action=delete&id=%@",[[dataArray objectAtIndex:indexPath.row] valueForKey:@"ID"]] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [dataArray removeObjectAtIndex:indexPath.row];
        [selectButtonArray removeObjectAtIndex:indexPath.row];
        [selectedSumArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@",error);
    }];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
