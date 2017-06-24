//
//  HomeViewController.m
//  易购超市
//
//  Created by vison on 2017/4/18.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchBar.h"
#import "MainView.h"
#import "Good.h"
#import "ClassesViewController.h"
#import "DetailsViewController.h"
#import "DataArray.h"


@interface HomeViewController ()<MainViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSMutableArray *dataArray;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏搜索框
    SearchBar *searchBar = [[SearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 120, 28)];
    self.navigationItem.titleView = searchBar;
    
    
    //导航栏扫一扫
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,25,25)];
    [leftButton setImage:[UIImage imageNamed:@"扫一扫"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(saoyisaoAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    //导航栏电话
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButton setImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(callupAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    //主界面
    dataArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;     //去除导航栏对布局的影响
    UICollectionViewFlowLayout *mainFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [mainFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    MainView *mainView = [[MainView alloc] initWithFrame:CGRectMake(0, HEIGHT_STATUSBAR + HEIGHT_NAVBAR, SCREEN_WIDTH, SCREEN_HEIGHT - HEIGHT_STATUSBAR - HEIGHT_NAVBAR - HEIGHT_TABBAR) collectionViewLayout:mainFlowLayout];
    mainView.bounces = NO;
    mainView.deleGate = self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];     //网络请求数据
    [manager GET:@"http://localhost/Test/admin.php" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Good *good = [[Good alloc] init];
        dataArray = [good makeItGoodArrayWith:responseObject];
        [DataArray shared].allDataArray = dataArray;
        [mainView transferDataWith:dataArray];
        [self.view addSubview:mainView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@",error);
        UILabel *failureLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 200)/2, SCREEN_HEIGHT/2 - 50, 200, 20)];
        failureLabel.text = @"无网络连接";
        failureLabel.textAlignment = NSTextAlignmentCenter;
        failureLabel.font = [UIFont systemFontOfSize:20];
        failureLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
        [self.view addSubview:failureLabel];
    }];

}

//扫一扫点击事件
- (void)saoyisaoAction {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//电话点击事件
- (void)callupAction {
    NSMutableString *telephoneNum = [[NSMutableString alloc] initWithFormat:@"tel:%@",@"15659430343"];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:telephoneNum]]];
    [self.view addSubview:callWebview];
}

//代理点击商品类别跳转界面
- (void)passCategoryClickActionAbout:(NSString *)categoryStr {
    ClassesViewController *classesViewController = [[ClassesViewController alloc] init];
//    classesViewController.view.backgroundColor = [UIColor whiteColor];
    classesViewController.dataArray = dataArray;
    classesViewController.categoryStr = categoryStr;
    //自定义返回按钮
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backBar];
    [self.navigationController pushViewController:classesViewController animated:YES];
}

//代理点击商品跳转界面
- (void)passGoodsClickActionAbout:(NSDictionary *)goodDic {
    DetailsViewController *detailViewController = [[DetailsViewController alloc] init];
//    detailViewController.view.backgroundColor = [UIColor whiteColor];
    detailViewController.goodDic = goodDic;
    //自定义返回按钮
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backBar];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

//代理点击抢购商品跳转界面
- (void)passCountDownClickActionAbout:(NSDictionary *)goodDic {
    DetailsViewController *detailViewController = [[DetailsViewController alloc] init];
    //    detailViewController.view.backgroundColor = [UIColor whiteColor];
    detailViewController.goodDic = goodDic;
    //自定义返回按钮
    UIBarButtonItem *backBar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backBar];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


@end
