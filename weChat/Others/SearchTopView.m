//
//  SearchTopView.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "SearchTopView.h"

@implementation SearchTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMain];
    }
    return self;
}


-(void)setupMain{
    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 8, self.frame.size.width - 15, self.frame.size.height - 16)];
    searchBar.backgroundImage = [UIImage imageNamed:@"widget_searchbar_cell_bg"];
    [self addSubview:searchBar];
    searchBar.placeholder = @"搜索";
    [searchBar setImage:[UIImage imageNamed:@"VoiceSearchStartBtn"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    [searchBar setImage:[UIImage imageNamed:@"VoiceSearchStartBtnHL"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateHighlighted];
    searchBar.showsBookmarkButton = YES;
    
}

@end
