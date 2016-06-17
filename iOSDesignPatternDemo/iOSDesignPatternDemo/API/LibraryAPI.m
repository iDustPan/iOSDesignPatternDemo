//
//  LibraryAPI.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "LibraryAPI.h"

@implementation LibraryAPI

/*
 1.声明一个静态变量去保存类的实例，确保它在类中的全局可用性。
 2.声明一个静态变量dispatch_once_t ,它确保初始化器代码只执行一次
 3.使用Grand Central Dispatch(GCD)执行初始化LibraryAPI变量的block.这正是单例模式的关键：一旦类已经被初始化，初始化器永远不会再被调用。
 */
+ (instancetype)sharedInstance {
    static LibraryAPI *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

@end
