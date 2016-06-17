//
//  AlbumView.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "AlbumView.h"

@interface AlbumView ()

@property (nonatomic, strong) UIImageView *coverImage;

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation AlbumView

#pragma mark - lazyLoad

- (UIImageView *)coverImage {
    if (!_coverImage) {
        _coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10)];
    }
    return _coverImage;
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        // 网络指示器
        _indicator = [[UIActivityIndicatorView alloc] init];
        _indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [_indicator startAnimating];
    }
    return _indicator;
}

#pragma mark - initiallize

- (instancetype)initWithFrame:(CGRect)frame albumCover:(NSString *)albumCover {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
       //   添加封面图
        [self addSubview:self.coverImage];
        //  添加下载指示器
        [self addSubview:self.indicator];
    }
    return self;
}

@end
