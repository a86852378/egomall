//
//  AddressViewController.m
//  易购超市
//
//  Created by vison on 2017/5/14.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *addressTableView;
    UIView *saveView;
    UIButton *saveButton;
    NSArray *addressNameArray;
    NSMutableArray *addressArray;
    NSString *addressStr;
}

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    __weak typeof(self.view) weakSelf = self.view;
    addressNameArray = [NSArray array];
    addressNameArray = @[@"请输入学校",@"请输入生活区",@"请输入宿舍楼",@"请输入宿舍号"];
    addressArray = [NSMutableArray array];
    
    addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [addressTableView registerClass:[UITableViewCell class]
             forCellReuseIdentifier:@"addressTableViewCell"];
    addressTableView.bounces = NO;
    addressTableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    addressTableView.dataSource = self;
    addressTableView.delegate = self;
    UIView *footView = [[UIView alloc] init];
    footView.backgroundColor = [UIColor whiteColor];
    addressTableView.tableFooterView = footView;
    [self.view addSubview:addressTableView];
    [addressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(64);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-40);
    }];
    
    saveView = [[UIView alloc] init];
    saveView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:saveView];
    [saveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.equalTo(@40);
    }];
    
    saveButton = [[UIButton alloc] init];
    [saveButton setTitle:@"保 存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.cornerRadius = 3;
    saveButton.backgroundColor = [UIColor orangeColor];
    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [saveView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(saveView).with.insets(UIEdgeInsetsMake(5, 20, 5, 20));
    }];

}


- (void)saveButtonAction {
    addressStr = [NSString string];
    for(UITextField *str in addressArray){
        addressStr = [addressStr stringByAppendingString:str.text];
    }
    User *user = [User shared];
    user.address = [addressStr copy];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return addressNameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UITextField *cellTextField = [[UITextField alloc] init];
    cellTextField.font = [UIFont systemFontOfSize:13];
    cellTextField.placeholder = addressNameArray[indexPath.row];
    [cell addSubview:cellTextField];
    [cellTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell).with.insets(UIEdgeInsetsMake(5, 20, 5, 20));
    }];
    [addressArray addObject:cellTextField];
    return cell;
}


@end
