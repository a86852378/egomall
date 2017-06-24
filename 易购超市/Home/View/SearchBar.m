//
//  SearchBar.m
//  易购超市
//
//  Created by vison on 2017/4/17.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
        searchBar.placeholder = @"今日水果半价";
        searchBar.layer.cornerRadius = 14;
        searchBar.layer.masksToBounds = YES;
        [self addSubview:searchBar];        
    }
    return self;
}

@end
