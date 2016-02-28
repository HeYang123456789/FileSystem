//
//  ViewController.m
//  FileSystem
//
//  Created by HeYang on 15/11/8.
//  Copyright © 2015年 HeYang. All rights reserved.
//

#import "ViewController.h"
#import "FileCell.h"
#import "File.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) File        *root;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Root";
    
    [self initFileModels];
    [self initTableView];
}
#pragma mark - 初始化文件模型的组合关系
- (void)initFileModels{
    
    // 创建根节点
    self.root = [File fileWithFileType:kFolder fileName:@"root"];
    
    // 创建第一级文件
    File *folder_A_1 = [File fileWithFileType:kFolder fileName:@"Folder-A-1"];
    File *file_A_2   = [File fileWithFileType:kFile fileName:@"File-A-2"];
    File *file_A_3   = [File fileWithFileType:kFile fileName:@"File-A-3"];
    File *file_A_4   = [File fileWithFileType:kFile fileName:@"File-A-4"];
    
    // 创建第二级文件
    File *folder_B_1 = [File fileWithFileType:kFolder fileName:@"Folder-B-1"];
    File *file_B_2   = [File fileWithFileType:kFile fileName:@"File-B-2"];
    File *file_B_3   = [File fileWithFileType:kFile fileName:@"File-B-3"];
    File *folder_B_2 = [File fileWithFileType:kFolder fileName:@"Folder-B-2"];
    
    // 创建第三级文件
    File *folder_C_1 = [File fileWithFileType:kFolder fileName:@"Folder-C-1"];
    File *file_C_1   = [File fileWithFileType:kFile fileName:@"File-C-1"];
    File *file_C_2   = [File fileWithFileType:kFile fileName:@"File-C-2"];
    
    [self.root addFile:folder_A_1];
    [self.root addFile:file_A_2];
    [self.root addFile:file_A_3];
    [self.root addFile:file_A_4];
    
    [folder_A_1 addFile:folder_B_1];
    [folder_A_1 addFile:file_B_2];
    [folder_A_1 addFile:file_B_3];
    [folder_A_1 addFile:folder_B_2];
    
    [folder_B_1 addFile:folder_C_1];
    [folder_B_1 addFile:file_C_1];
    [folder_B_2 addFile:file_C_2];
    
    // 以上操作是：需要手动创建和设置 所有的 文件和文件目录
    // hy:我的改进思路：
    //      第一次进入该ViewController的时候
    //      每次进入一个ViewController，都需要在这个viewDidLoad方法里，
    //      遍历他们的Folder的子Cell，获取一级子cell对应的file模型对象，并存储在各自的cell中
    //      仅仅一级就可以了，因为进入第二级ViewController的时候又会加载它下一级的cell对应的file模型对象
}
#pragma mark - 初始化tableView
- (void)initTableView {
    
    // 创建tableview，并设置frame和style。
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // 设置代理对象
    self.tableView.delegate       = self;
    self.tableView.dataSource     = self;
    // 取消tableview的Separator的线条
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册tableview
    [self.tableView registerClass:[FileCell class] forCellReuseIdentifier:@"fileCell"];
    
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView的代理方法
// 设置cell行数的方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.root.childFiles.count;
}
// 加载对应Cell的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FileCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"fileCell"];
    
    // 感觉这个是多余的
    cell.indexPath  = indexPath;
    cell.tableView  = tableView;
    cell.controller = self;
    
    // 传入节点File对象 拿到当前根目录的数组，然后通过数组的index拿到对应cell的file模型对象
    cell.data       = self.root.childFiles[indexPath.row];
    
    // 设置好当前的cell之后，就需要加载cell控件上的UI显示状态
    [cell loadContent];
    
    return cell;
}
// 设置cell的高度的方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}

@end
