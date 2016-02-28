//
//  FileViewController.m
//  FileSystem
//
//  Created by HeYang on 15/11/8.
//  Copyright © 2015年 HeYang. All rights reserved.
//

#import "FileViewController.h"
#import "FileCell.h"

@interface FileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FileViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = self.rootFile.name;
    
    [self initTableView];
}

#pragma mark - tableView相关
- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[FileCell class] forCellReuseIdentifier:@"fileCell"];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.rootFile.childFiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"fileCell"];
    cell.indexPath  = indexPath;
    cell.tableView  = tableView;
    cell.controller = self;
    
    // 传入子节点的File对象
    cell.data       = self.rootFile.childFiles[indexPath.row];
    
    [cell loadContent];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.f;
}


@end
