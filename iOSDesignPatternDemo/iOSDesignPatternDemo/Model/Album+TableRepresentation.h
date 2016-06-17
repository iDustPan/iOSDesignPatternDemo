//
//  Album+TableRepresentation.h
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)

- (NSDictionary*)tr_tableRepresentation;

@end
