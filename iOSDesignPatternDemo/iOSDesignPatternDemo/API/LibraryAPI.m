//
//  LibraryAPI.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "LibraryAPI.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"
#import "Album.h"

#define BLDownloadImageNotification @"BLDownloadImageNotification"

@interface LibraryAPI ()

@property (nonatomic, strong) HTTPClient *httpClient;

@property (nonatomic, strong) PersistencyManager *persistencyManager;

@property (nonatomic, assign) BOOL isOnline;

@end

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

- (instancetype)init {
    if (self = [super init]) {
        self.httpClient = [[HTTPClient alloc] init];
        self.persistencyManager = [[PersistencyManager alloc] init];
        self.isOnline = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downloadImage:)
                                                     name:BLDownloadImageNotification
                                                   object:nil];
    }
    return self;
}

- (void)saveAlbums {
    [self.persistencyManager saveAlbums];
}

- (NSArray*)getAlbums {
    return [self.persistencyManager getAlbums];
}

/**
 *  我们来看一看addAlbum:atIndex:.这个类首先更新本地的数据，然后如果有网络连接，它更新远程服务器。这就是外观模式的强大之处。当某些外部的类增加一个新的专辑的时候，它不知道也不需要知道背后的复杂性。
 注意:当为子系统的类设计外观的时候，要记住：任何东西都不能阻止客户端直接访问这些隐藏的类。不要对这些防御性的代码太过于吝啬，并且也不要假设所有的客户端都会和外观一样使用你的类。
 *
 *  @param album 专辑对象
 *  @param index 专辑索引
 */
- (void)addAlbum:(Album *)album atIndex:(int)index {
    [self.persistencyManager addAlbum:album atIndex:index];
    
    if (_isOnline) {
        [self.httpClient postRequest:@"/api/addAlbum" body:[album description]];
    }
}

- (void)deleteAlbumAtIndex:(int)index {
    
    [self.persistencyManager deleteAlbumAtIndex:index];
    
    if (_isOnline)
    {
        [self.httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}

- (void)downloadImage:(NSNotification*)notification

{
    
    // 1
    UIImageView *imageView = notification.userInfo[@"imageView"];
    
    NSString *coverUrl = notification.userInfo[@"coverUrl"];
    
    // 2
    
    imageView.image = [self.persistencyManager getImage:[coverUrl lastPathComponent]];
    
    if (imageView.image == nil)
        
    {
        
        // 3
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *image = [self.httpClient downloadImage:coverUrl];
            
            // 4
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                imageView.image = image;
                
                [self.persistencyManager saveImage:image filename:[coverUrl lastPathComponent]];
                
            });
            
        });
        
    }   
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
