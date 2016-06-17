//
//  Album.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "Album.h"

@implementation Album



- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist
                     coverUrl:(NSString *)coverUrl year:(NSString *)year {
    
    if (self = [super init]) {
        //注意，只读属性这里不能用点语法，等号左边的点语法实际上是setter方法，而只读属性默认是不生成setter方法的
        _title = title;
        _artist = artist;
        _genre = @"Pop";
        _coverUrl = coverUrl;
        _year = year;
    }
    
    return self;
}

@end
