//
//  PersistencyManager.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "PersistencyManager.h"
#import "Album.h"

@interface PersistencyManager ()

@property (nonatomic, strong) NSMutableArray *albums;

@end

@implementation PersistencyManager

- (NSArray *)getAlbums {
    return self.albums;
}

- (void)addAlbum:(Album *)album atIndex:(NSInteger)index {
    //  注意数组长度的问题
    if (self.albums.count >= index) {
        [self.albums insertObject:album atIndex:index];
    } else {
        [self.albums addObject:album];
    }
}

- (void)deleteAlbumAtIndex:(NSInteger)index {
    
    //  注意数组长度的问题
    if (self.albums.count < index) {
        NSLog(@"并没有盖章专辑啊～");
        return;
    }
    [self.albums removeObjectAtIndex:index];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // a dummy list of albums
        self.albums = [NSMutableArray arrayWithArray:
                  @[[[Album alloc] initWithTitle:@"Best of Bowie" artist:@"David Bowie" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_david%20bowie_best%20of%20bowie.png" year:@"1992"],
                    [[Album alloc] initWithTitle:@"It's My Life" artist:@"No Doubt" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_no%20doubt_its%20my%20life%20%20bathwater.png" year:@"2003"],
                    [[Album alloc] initWithTitle:@"Nothing Like The Sun" artist:@"Sting" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png" year:@"1999"],
                    [[Album alloc] initWithTitle:@"Staring at the Sun" artist:@"U2" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png" year:@"2000"],
                    [[Album alloc] initWithTitle:@"American Pie" artist:@"Madonna" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_madonna_american%20pie.png" year:@"2000"]]];
    }
    return self;
}

@end
