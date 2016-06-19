//
//  PersistencyManager.h
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Album;

@interface PersistencyManager : NSObject


- (NSArray *)getAlbums;

- (void)addAlbum:(Album *)album atIndex:(NSInteger)index;

- (void)deleteAlbumAtIndex:(NSInteger)index;

- (void)saveAlbums;

- (void)saveImage:(UIImage *)image filename:(NSString*)filename;

- (UIImage *)getImage:(NSString*)filename;

@end
