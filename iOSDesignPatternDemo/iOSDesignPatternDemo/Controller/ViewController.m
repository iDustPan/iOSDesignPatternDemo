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

- (UITableView *)dataTable {
    if (!_dataTable) {
        _dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, self.view.bounds.size.height - 120) style:UITableViewStyleGrouped];
        _dataTable.dataSource = self;
        _dataTable.delegate = self;
        _dataTable.backgroundView = nil;
    }
    return _dataTable;
}

- (NSArray *)allAlbums {
    if (!_allAlbums) {
        _allAlbums = [[LibraryAPI sharedInstance] getAlbums];
    }
    return _allAlbums;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.76f green:0.81f blue:0.87f alpha:1];
    self.currentAlbumIndex = 0;
    
    [self.view addSubview:self.dataTable];
    
    [self showDataForAlbumAtIndex:self.currentAlbumIndex];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
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
    }
    else
    {
        self.currentAlbumData = nil;
    }
    
    // we have the data we need, let's refresh our tableview
    [self.dataTable reloadData];
}


#pragma mark -
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

@end
