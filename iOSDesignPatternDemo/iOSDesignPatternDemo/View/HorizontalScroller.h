//
//  HorizontalScroller.h
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/18.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HorizontalScrollerDelegate;

@interface HorizontalScroller : UIView

@property (nonatomic, weak) id<HorizontalScrollerDelegate> delegate;

- (void)reload;

@end

@protocol HorizontalScrollerDelegate <NSObject>

@required

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller;

- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(NSInteger)index;

- (void)horizontalScroller:(HorizontalScroller *)scroller didSelectedViewAtIndex:(NSInteger)index;

@optional
/**
 *  初始化显示的专辑视图
 *
 *  @param scroller 专辑书架
 *
 *  @return 默认返回0
 */
- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller*)scroller;

@end
