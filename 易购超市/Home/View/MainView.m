//
//  MainView.m
//  易购超市
//
//  Created by vison on 2017/4/30.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "MainView.h"
#import "RollCollectionView.h"
#import "CategoryCollectionView.h"
#import "CountDownGoodView.h"
#import "GoodsTableView.h"

@interface MainView()<UICollectionViewDataSource,UICollectionViewDelegate,CategoryCollectionDelegate,GoodsTableViewDelegate,CountDownGoodViewDelegate> {
    RollCollectionView *rollCollectionView;
    CategoryCollectionView *categoryCollectionView;
    CountDownGoodView *countDownGoodView;
    GoodsTableView *goodsTableView;
    NSMutableArray *hotGoodsArray;
}

@end
@implementation MainView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        self.showsVerticalScrollIndicator = NO;
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MainViewCell"];
        
        hotGoodsArray = [NSMutableArray array];
    }
    return self;
}

#pragma collectionView delegate && dataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainViewCell" forIndexPath:indexPath];
    if(indexPath.item == 0){
        //轮播图
        UICollectionViewFlowLayout *rollFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [rollFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        rollCollectionView = [[RollCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120) collectionViewLayout:rollFlowLayout];
        [cell addSubview:rollCollectionView];
        
    }else if(indexPath.item == 1){
        //商品类别
        UICollectionViewFlowLayout *categoryFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        categoryCollectionView = [[CategoryCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 130) collectionViewLayout:categoryFlowLayout];
        categoryCollectionView.deleGate = self;
        [cell addSubview:categoryCollectionView];
        
    }else if(indexPath.item == 2){
        //今日限时抢购
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
        titleView.backgroundColor = [UIColor whiteColor];
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 80)/2, 3, 14, 14)];
        titleImageView.image = [UIImage imageNamed:@"时间"];
        [titleView addSubview:titleImageView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(((self.frame.size.width - 80)/2) + 20, 2, 55, 16)];
        titleLabel.text = @"限时抢购";
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        [titleView addSubview:titleLabel];
        [cell addSubview:titleView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 24, self.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [cell addSubview:lineView];
        
    }else if(indexPath.item == 3){
        //今日限时抢购
        countDownGoodView = [[CountDownGoodView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
        countDownGoodView.deleGate = self;
        [cell addSubview:countDownGoodView];
        
    }else if(indexPath.item == 4){
        //今日热销标题
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
        titleView.backgroundColor = [UIColor whiteColor];
        UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 80)/2, 3, 14, 14)];
        titleImageView.image = [UIImage imageNamed:@"热销"];
        [titleView addSubview:titleImageView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(((self.frame.size.width - 80)/2) + 20, 2, 55, 16)];
        titleLabel.text = @"今日热销";
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:12];
        [titleView addSubview:titleLabel];
        [cell addSubview:titleView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 24, self.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [cell addSubview:lineView];

    }else if(indexPath.item == 5){
        //今日热销
        goodsTableView = [[GoodsTableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20) style:UITableViewStylePlain];
        goodsTableView.bounces = NO;
        [goodsTableView transferDataWith:hotGoodsArray];
        goodsTableView.deleGate = self;
        [cell addSubview:goodsTableView];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.item == 0){
        return CGSizeMake(self.frame.size.width, 120);
    }
    else if(indexPath.item == 1){
        return CGSizeMake(self.frame.size.width, 130);
    }
    else if(indexPath.item == 2 ||indexPath.item == 4){
        return CGSizeMake(self.frame.size.width, 25);
    }
    else if(indexPath.item == 3){
        return CGSizeMake(self.frame.size.width, 120);
    }
    else if(indexPath.item == 5){
        return CGSizeMake(self.frame.size.width, self.frame.size.height - 20);
    }
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)transferDataWith:(NSMutableArray *)array {
    hotGoodsArray = array;
}

//传递商品类别代理点击函数
- (void)categoryClickActionAbout:(NSString *)categoryStr {
    if(self.deleGate && [self.deleGate respondsToSelector:@selector(passCategoryClickActionAbout:)]){
        [self.deleGate passCategoryClickActionAbout:categoryStr];
    }
}

//传递商品代理点击函数
- (void)goodsClickActionAbout:(NSDictionary *)goodDic {
    if(self.deleGate && [self.deleGate respondsToSelector:@selector(passGoodsClickActionAbout:)]){
        [self.deleGate passGoodsClickActionAbout:goodDic];
    }
}

//传递限时抢购商品点击函数
- (void)countDownClickActionAbout:(NSDictionary *)goodDic {
    if(self.deleGate && [self.deleGate respondsToSelector:@selector(passCountDownClickActionAbout:)]){
        [self.deleGate passCountDownClickActionAbout:goodDic];
    }
}

@end
