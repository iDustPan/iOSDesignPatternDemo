//
//  AlbumView.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "AlbumView.h"

#define BLDownloadImageNotification @"BLDownloadImageNotification"

@interface AlbumView ()

@property (nonatomic, strong) UIImageView *coverImage;

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation AlbumView

#pragma mark - 懒加载－UI控件

- (UIImageView *)coverImage {
    if (!_coverImage) {
        _coverImage = [[UIImageView alloc] init];
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
        
        [self.coverImage addObserver:self forKeyPath:@"image" options:0 context:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BLDownloadImageNotification
                                                            object:self
                                                          userInfo:@{
                                                                     @"imageView": self.coverImage, @"coverUrl": albumCover
                                                                     }];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    
    if ([keyPath isEqualToString:@"image"]) {
        [self.indicator stopAnimating];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.coverImage.frame = CGRectMake(5, 5, self.frame.size.width - 10, self.frame.size.height - 10);
    self.indicator.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}

- (void)dealloc {
    [self.coverImage removeObserver:self forKeyPath:@"image"];
}
@end
