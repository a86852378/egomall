//
//  MeViewController.m
//  易购超市
//
//  Created by vison on 2017/5/10.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "MeViewController.h"
#import "LoginViewController.h"
#import "OrderViewController.h"
#import "AddressViewController.h"
#import "SetViewController.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *backgroundImageView;
    UIImageView *headImageView;
    UILabel *nameLabel;
    UILabel *phoneLabel;
    UITableView *objectsTableView;
    NSArray *array;
}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [objectsTableView removeFromSuperview];
    if(isLoged){
        [self addView];
    }
    else{
        __weak typeof (self.view) weakSelf = self.view;

        UIButton *loginButton = [[UIButton alloc] init];
        [loginButton.layer setBorderWidth:0.3];
        loginButton.layer.borderColor = [UIColor redColor].CGColor;
        loginButton.layer.cornerRadius = 5;
        [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [loginButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loginButton];
        [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
    }

}

- (void)addView {
    __weak typeof (self.view) weakSelf = self.view;
    
    array = [NSArray array];
    array = @[@"我的订单",@"收货地址",@"设置"];
    
    User *user = [User shared];

    backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    backgroundImageView.image = [UIImage imageNamed:@"背景"];
    
    headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"头像"];
    headImageView.layer.cornerRadius = 35;
    headImageView.layer.masksToBounds = YES;
    [backgroundImageView addSubview:headImageView];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = user.name;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:24];
    [backgroundImageView addSubview:nameLabel];
    
    phoneLabel = [[UILabel alloc] init];
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = [NSString stringWithFormat:@"账号:%@",user.phoneNumber];
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [backgroundImageView addSubview:phoneLabel];
    
    objectsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [objectsTableView registerClass:[UITableViewCell class]
             forCellReuseIdentifier:@"personTableViewCell"];
    objectsTableView.bounces = NO;
    objectsTableView.dataSource = self;
    objectsTableView.delegate = self;
    [self.view addSubview:objectsTableView];
    
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    objectsTableView.tableFooterView = footView;
    
    objectsTableView.tableHeaderView = backgroundImageView;
    
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundImageView).with.offset(35);
        make.left.equalTo(backgroundImageView).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundImageView).with.offset(40);
        make.left.equalTo(headImageView.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom);
        make.left.equalTo(headImageView.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    [objectsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(64);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf).with.offset(-49);
    }];

}

- (void)loginButtonAction {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    loginViewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personTableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *cellImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
    cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",array[indexPath.row]]];
    [cell addSubview:cellImageView];
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
    cellLabel.text = [NSString stringWithFormat:@"%@", array[indexPath.row]];
    cellLabel.font = [UIFont systemFontOfSize:14];
    [cell addSubview:cellLabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backBar];
        OrderViewController *orderViewController = [[OrderViewController alloc] init];
        orderViewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:orderViewController animated:YES];
    }
    else if(indexPath.row == 1){
        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backBar];
        AddressViewController *addressViewController = [[AddressViewController alloc] init];
        [self.navigationController pushViewController:addressViewController animated:YES];
    }
    else if(indexPath.row == 2){
        UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
        [self.navigationItem setBackBarButtonItem:backBar];
        SetViewController *setViewController = [[SetViewController alloc] init];
        setViewController.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:setViewController animated:YES];
    }
}


@end
