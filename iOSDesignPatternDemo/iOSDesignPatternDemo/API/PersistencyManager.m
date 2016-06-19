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

- (void)saveAlbums {
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/albums.bin"];
    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.albums];
//    [data writeToFile:filename atomically:YES];
    ![NSKeyedArchiver archiveRootObject:self.albums toFile:filename] ? NSLog(@"归档失败") : NSLog(@"归档成功");
    
}

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
        
//        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/albums.bin"]];
//        
//        self.albums = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        self.albums = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/albums.bin"]];
        
        if (self.albums != nil) return self;
        
        self.albums = [NSMutableArray arrayWithArray:
                  @[[[Album alloc] initWithTitle:@"Best of Bowie" artist:@"David Bowie" coverUrl:@"http://t-1.tuzhan.com/422022f85414/c-2/l/2013/05/23/22/ee4dd25e87fb4b27b63710ea6945491b.jpg" year:@"1992"],
                    [[Album alloc] initWithTitle:@"It's My Life" artist:@"No Doubt" coverUrl:@"http://i.epetbar.com/2014-06/07/a08a0303f1e8e41b880588891c453b16.jpg" year:@"2003"],
                    [[Album alloc] initWithTitle:@"Nothing Like The Sun" artist:@"Sting" coverUrl:@"http://www.meiwai.net/uploads/allimg/c150822/1440244203H130-15524.png" year:@"1999"],
                    [[Album alloc] initWithTitle:@"Staring at the Sun" artist:@"U2" coverUrl:@"http://www.meiwai.net/uploads/allimg/c150907/14416140N1GZ-51951.jpg" year:@"2000"],
                    [[Album alloc] initWithTitle:@"American Pie" artist:@"Madonna" coverUrl:@"http://p3.gexing.com/G1/M00/CB/00/rBACFFKR5mDScmocAABWdHJnshw497.jpg" year:@"2000"]]];
        [self saveAlbums];
    }
    return self;
}

- (void)saveImage:(UIImage*)image filename:(NSString*)filename
{
    
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    [data writeToFile:filename atomically:YES];
    
}

- (UIImage*)getImage:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    
    NSData *data = [NSData dataWithContentsOfFile:filename];
    
    return [UIImage imageWithData:data];
}

@end
