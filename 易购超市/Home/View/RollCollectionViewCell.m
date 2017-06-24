//
//  RollCollectionViewCell.m
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "RollCollectionViewCell.h"

@interface RollCollectionViewCell() {
    UIImageView *imageView;
}
@end

@implementation RollCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 120)];
        [self addSubview:imageView];
    }
    return self;
}

- (void)getImage:(UIImage *)image {
    [imageView setImage:image];
}

@end
