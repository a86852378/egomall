//
//  CategoryCollectionView.m
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "CategoryCollectionView.h"
#import "CategoryCollectionViewCell.h"

@interface CategoryCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSArray *categoryArray;
}
@end

@implementation CategoryCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        categoryArray = [NSArray array];
        categoryArray = @[@"全部",@"休闲零食",@"饮料",@"水果",@"熟食",@"日常用品",@"个人护理",@"文具",@"小型电器",@"其它"];

        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"categoryCollectionViewCell"];
    }
    return self;
}

#pragma collectionView delegate && dataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *categoryCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"categoryCollectionViewCell" forIndexPath:indexPath];
    [categoryCollectionViewCell getImage:categoryArray[indexPath.item]];
    return categoryCollectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width/5, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.deleGate && [self.deleGate respondsToSelector:@selector(categoryClickActionAbout:)]){
        [self.deleGate categoryClickActionAbout:categoryArray[indexPath.item]];
    }
}


@end
