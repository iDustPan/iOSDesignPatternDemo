//
//  Album.h
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//title, *artist, *genre, *coverUrl, *year;

#import <Foundation/Foundation.h>

@interface Album : NSObject<NSCoding>

/** 专辑名 */
@property (nonatomic, copy, readonly) NSString *title;
/** 艺人 */
@property (nonatomic, copy, readonly) NSString *artist;

@property (nonatomic, copy, readonly) NSString *genre;
/** 网址 */
@property (nonatomic, copy, readonly) NSString *coverUrl;
/** 发布年 */
@property (nonatomic, copy, readonly) NSString *year;

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist coverUrl:(NSString *)coverUrl year:(NSString *)year;

@end
