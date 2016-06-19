//
//  HorizontalScroller.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/18.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "HorizontalScroller.h"

// 专辑视图间间距
#define VIEW_PADDING 10
// 专辑视图尺寸
#define VIEW_DIMENSIONS 100
// 左右边距
#define VIEWS_OFFSET 100

@interface HorizontalScroller ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroller;

@end

@implementation HorizontalScroller

- (UIScrollView *)scroller
{
    if (!_scroller) {
        _scroller = [[UIScrollView alloc] init];
        _scroller.delegate = self;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTapped:)];
        [_scroller addGestureRecognizer:tapGestureRecognizer];
    }
    return _scroller;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scroller];
    }
    return self;
}

- (void)scrollerTapped:(UITapGestureRecognizer *)gesture
{
    CGPoint location = [gesture locationInView:gesture.view];
    
    for (NSInteger i = 0; i < [self.delegate numberOfViewsForHorizontalScroller:self]; i++) {
        UIView *view = self.scroller.subviews[i];
        if (CGRectContainsPoint(view.frame, location)) {
            [self.delegate horizontalScroller:self didSelectedViewAtIndex:i];
            [self.scroller setContentOffset:CGPointMake(view.frame.origin.x - self.bounds.size.width * 0.5 + view.frame.size.width * 0.5, 0) animated:YES];
            break;
        }
    }
}

- (void)reload
{
    if (self.delegate == nil) {
        return;
    }
    
    [self.scroller.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat xValue = VIEWS_OFFSET;
    for (NSInteger i = 0; i < [self.delegate numberOfViewsForHorizontalScroller:self]; i++) {
        
        xValue = VIEWS_OFFSET + (VIEW_DIMENSIONS + VIEW_PADDING) * i;
        
        UIView *view = [self.delegate horizontalScroller:self viewAtIndex:i];
        view.frame = CGRectMake(xValue, VIEW_PADDING, VIEW_DIMENSIONS, VIEW_DIMENSIONS);
        [self.scroller addSubview:view];
    }
    
    [self.scroller setContentSize:CGSizeMake(xValue + VIEW_DIMENSIONS + VIEWS_OFFSET, 0)];
    
    if ([self.delegate respondsToSelector:@selector(initialViewIndexForHorizontalScroller:)]) {
        NSInteger initialView = [self.delegate initialViewIndexForHorizontalScroller:self];
        [self.scroller setContentOffset:CGPointMake(initialView * (VIEW_DIMENSIONS + (2 * VIEW_PADDING)), 0) animated:YES];
    }
}

- (void)didMoveToSuperview {
    [self reload];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scroller.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

//最后我们需要确保所有你正在浏览的专辑数据总是在滚动视图的中间。为了这样做，当用户的手指拖动滚动视图的时候，你将需要做一些计算。
- (void)centerCurrentView
{
    int xFinal = self.scroller.contentOffset.x + (VIEWS_OFFSET / 2) + VIEW_PADDING;
    
    int viewIndex = xFinal / (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    
    xFinal = viewIndex * (VIEW_DIMENSIONS + (2 * VIEW_PADDING));
    
    [self.scroller setContentOffset:CGPointMake(xFinal,0) animated:YES];
    
    [self.delegate horizontalScroller:self didSelectedViewAtIndex:viewIndex];
}


/*
 scrollViewDidEndDragging:willDecelerate:方法在用户完成拖动的时候通知委托。如果视图还没有完全的停止，那么decelerate参数为true.当滚动完全停止的时候，系统将会调用scrollViewDidEndDecelerating.在两种情况下，我们都需要调用我们新增的方法去置中当前的视图，因为当前的视图在用户拖动以后可能已经发生了变化。
 
 你的HorizontalScroller现在已经可以使用了。浏览你刚刚写的代码，没有涉及到任何与Album或AlbumView类的信息。这个相对的棒，因为这意味着这个新的滚动视图是完全的独立和可复用的。
 
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self centerCurrentView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self centerCurrentView];
}



@end
