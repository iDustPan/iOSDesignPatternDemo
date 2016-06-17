//
//  PersistencyManager.h
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Album;

@interface PersistencyManager : NSObject


- (NSArray *)getAlbums;

- (void)addAlbum:(Album *)album atIndex:(NSInteger)index;

- (void)deleteAlbumAtIndex:(NSInteger)index;

@end
