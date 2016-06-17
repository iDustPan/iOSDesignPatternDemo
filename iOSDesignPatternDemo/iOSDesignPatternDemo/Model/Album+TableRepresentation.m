//
//  Album+TableRepresentation.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)
/*
 咱们稍停片刻，来看看这个模式的强大之处：
 1.你可以直接使用Album的属性
 2.你不需要子类化就可以增加方法。当然如果你想子类化Album，你任然可以那样做。
 3.简简单单的几句代码就让你在不修改Album的情况下，返回了一个UITableView风格的Album。
 
 */
- (NSDictionary*)tr_tableRepresentation {
    return @{@"titles":@[@"Artist", @"Album", @"Genre", @"Year"],
             @"values":@[self.artist, self.title, self.genre, self.year]};
}

@end
