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

/**
 *  专辑模型初始化接口
 *
 *  @param title    专辑标题
 *  @param artist   专辑艺术家
 *  @param coverUrl 封面地址
 *  @param year     发布年
 *
 *  @return 保存的专辑模型
 */
- (instancetype)initWithTitle:(NSString *)title
                       artist:(NSString *)artist
                     coverUrl:(NSString *)coverUrl
                         year:(NSString *)year;

@end
