//
//  RollCollectionView.m
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "RollCollectionView.h"
#import "RollCollectionViewCell.h"

@interface RollCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate> {
    NSMutableArray *rollImageArray;
    UIPageControl *pageControl;
}

@end

@implementation RollCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        //暂时的图片资源
        rollImageArray = [NSMutableArray array];
        NSError *error;
        NSURL *url = [NSURL URLWithString:@"https://gw.alicdn.com/tfs/TB1urj0QVXXXXXbaFXXXXXXXXXX-750-291.jpg_Q90.jpg"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        UIImage *image = [UIImage imageWithData:data];
        [rollImageArray addObject:image];
        NSURL *url1 = [NSURL URLWithString:@"https://img.alicdn.com/imgextra/i1/880734502/TB20MEPpHBmpuFjSZFAXXaQ0pXa-880734502.jpg_Q90.jpg"];
        NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
        NSData *data1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:&error];
        UIImage *image1 = [UIImage imageWithData:data1];
        [rollImageArray addObject:image1];
        NSURL *url2 = [NSURL URLWithString:@"https://img.alicdn.com/imgextra/i3/1910146537/TB2BurJoBNkpuFjy0FaXXbRCVXa_!!1910146537.jpg_Q90.jpg"];
        NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
        NSData *data2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:&error];
        UIImage *image2 = [UIImage imageWithData:data2];
        [rollImageArray addObject:image2];

        //分页控制器
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.frame.size.width - 40)/2, 100, 40, 10)];
        pageControl.numberOfPages = rollImageArray.count;
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        [self addSubview:pageControl];
        
        
        self.contentSize = CGSizeMake(self.frame.size.width * (rollImageArray.count + 2), self.frame.size.height);
        self.contentOffset = CGPointMake(self.frame.size.width, 0);
        self.backgroundColor = [UIColor clearColor];
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[RollCollectionViewCell class] forCellWithReuseIdentifier:@"rollCollectionViewCell"];
        
        //轮播计时器
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(rollAction) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)rollAction{
    [self setContentOffset:CGPointMake(self.contentOffset.x + self.frame.size.width, 0) animated:YES];
}

#pragma collectionView delegate && dataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return rollImageArray.count + 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RollCollectionViewCell *rollCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rollCollectionViewCell" forIndexPath:indexPath];
    if(indexPath.item == 0){
        [rollCollectionViewCell getImage:[rollImageArray objectAtIndex:rollImageArray.count - 1]];
    }else if(indexPath.item == rollImageArray.count + 1){
        [rollCollectionViewCell getImage:[rollImageArray objectAtIndex:0]];
    }else{
        [rollCollectionViewCell getImage:[rollImageArray objectAtIndex:indexPath.item - 1]];
    }
    return rollCollectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x == 0){
        scrollView.contentOffset = CGPointMake(self.frame.size.width * rollImageArray.count, 0);
    }
    if(scrollView.contentOffset.x == self.frame.size.width * (rollImageArray.count + 1)){
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    if(scrollView.contentOffset.x == 0){
        scrollView.contentOffset = CGPointMake(self.frame.size.width * rollImageArray.count, 0);
    }
    if(scrollView.contentOffset.x == self.frame.size.width * (rollImageArray.count + 1)){
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
}


@end
