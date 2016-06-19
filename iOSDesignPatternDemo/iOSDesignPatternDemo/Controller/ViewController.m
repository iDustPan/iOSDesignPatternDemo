//
//  ViewController.m
//  iOSDesignPatternDemo
//
//  Created by 徐攀 on 16/6/17.
//  Copyright © 2016年 cn.xupan.www. All rights reserved.
//

#import "ViewController.h"
#import "LibraryAPI.h"
#import "Album+TableRepresentation.h"
#import "HorizontalScroller.h"
#import "AlbumView.h"

@interface ViewController () <
    UITableViewDataSource,
    UITableViewDelegate,
    HorizontalScrollerDelegate
>
//UITableView *dataTable;
//NSArray *allAlbums;
//NSDictionary *currentAlbumData;
//int currentAlbumIndex;

@property (nonatomic, strong) UITableView *dataTable;

@property (nonatomic, strong) HorizontalScroller *scroller;

@property (nonatomic, strong) NSArray *allAlbums;

@property (nonatomic, strong) NSDictionary *currentAlbumData;

@property (nonatomic, assign) NSInteger currentAlbumIndex;

@end

@implementation ViewController


#pragma mark - UI控件懒加载
- (UITableView *)dataTable {
    if (!_dataTable) {
        _dataTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _dataTable.dataSource = self;
        _dataTable.delegate = self;
        _dataTable.backgroundView = nil;
    }
    return _dataTable;
}

- (HorizontalScroller *)scroller {
    if (!_scroller) {
        _scroller = [[HorizontalScroller alloc] init];
        _scroller.backgroundColor = [UIColor colorWithRed:0.24 green:0.35 blue:0.49 alpha:1.0];
        _scroller.delegate = self;
    }
    return _scroller;
}

#pragma mark - 获取专辑数据
- (NSArray *)allAlbums {
    if (!_allAlbums) {
        _allAlbums = [[LibraryAPI sharedInstance] getAlbums];
    }
    return _allAlbums;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPreviousState];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1];
    
    self.currentAlbumIndex = 0;
    
    [self.view addSubview:self.dataTable];
    [self.view addSubview:self.scroller];
    
    [self reloadScroller];
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCurrentState) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.scroller.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    self.dataTable.frame = CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120);
}

- (void)showDataForAlbumAtIndex:(NSInteger)albumIndex
{
    // defensive code: make sure the requested index is lower than the amount of albums
    if (albumIndex < self.allAlbums.count)
    {
        // fetch the album
        Album *album = self.allAlbums[albumIndex];
        // save the albums data to present it later in the tableview
        self.currentAlbumData = [album tr_tableRepresentation];
    }else{
        self.currentAlbumData = nil;
    }
    
    // we have the data we need, let's refresh our tableview
    [self.dataTable reloadData];
}

- (void)reloadScroller {
    self.allAlbums = [[LibraryAPI sharedInstance] getAlbums];
    
    if (self.currentAlbumIndex < 0) {
        self.currentAlbumIndex = 0;
    }else if (self.currentAlbumIndex >= self.allAlbums.count) {
        self.currentAlbumIndex = self.allAlbums.count - 1;
    }
    
    [self.scroller reload];
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentAlbumData[@"titles"] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.currentAlbumData[@"titles"][indexPath.row];
    cell.detailTextLabel.text = self.currentAlbumData[@"values"][indexPath.row];
    return cell;
}

#pragma mark - HorizontalScrollerDelegate

- (void)horizontalScroller:(HorizontalScroller *)scroller didSelectedViewAtIndex:(NSInteger)index {
    self.currentAlbumIndex = index;
    [self showDataForAlbumAtIndex:index];
}

- (NSInteger)numberOfViewsForHorizontalScroller:(HorizontalScroller *)scroller {
    return self.allAlbums.count;
}

- (UIView *)horizontalScroller:(HorizontalScroller *)scroller viewAtIndex:(NSInteger)index {
    Album *album = self.allAlbums[index];
    return [[AlbumView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) albumCover:album.coverUrl];
}

- (NSInteger)initialViewIndexForHorizontalScroller:(HorizontalScroller *)scroller {
    return self.currentAlbumIndex;
}

#pragma mark - 备忘录模式
- (void)saveCurrentState
{
    
    // When the user leaves the app and then comes back again, he wants it to be in the exact same state
    
    // he left it. In order to do this we need to save the currently displayed album.
    
    // Since it's only one piece of information we can use NSUserDefaults.
    
    [[NSUserDefaults standardUserDefaults] setInteger:self.currentAlbumIndex forKey:@"currentAlbumIndex"];
    
    [[LibraryAPI sharedInstance] saveAlbums];
    
}

- (void)loadPreviousState

{
    
    self.currentAlbumIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentAlbumIndex"];
    
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
