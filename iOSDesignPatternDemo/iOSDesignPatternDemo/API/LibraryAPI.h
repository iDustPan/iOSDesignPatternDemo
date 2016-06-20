//
//  LibraryAPI.h
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Album;

@interface LibraryAPI : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)getAlbums;
- (void)addAlbum:(Album *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(NSInteger)index;

- (void)saveAlbums;


@end
