//
//  FileCell.m
//  CompositePattern
//
//  Created by HeYang on 15/10/20.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

#import "FileCell.h"
#import "UIView+SetRect.h"
#import "File.h"
#import "FileViewController.h"

@interface FileCell ()

// 显示"文件"和"文件夹"图标
@property (nonatomic, strong) UIImageView  *fileImageView;
@property (nonatomic, strong) UIImageView  *folderImageView;
// 图标上面显示的文件类型名
@property (nonatomic, strong) UILabel      *iconNameLabel;
// 具有点击事件的按钮，主要逻辑：点击跳转，模拟打开文件夹
@property (nonatomic, strong) UIButton     *button;
// 图标右边显示的文件名
@property (nonatomic, strong) UILabel      *nameLabel;

@end

@implementation FileCell

// UITableViewCell初始化的构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self buildView];
    }
    
    return self;
}

- (void)buildView {

    UIView *line         = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5f, 500, 0.5f)];
    line.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.25f];
    [self addSubview:line];
    
    // 先后添加"File"和"Folder"的UIImageView对象，然后显示状态通过hide属性控制，
    self.fileImageView   = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"File"]];
    self.folderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Folder"]];
    self.fileImageView.center   = CGPointMake(40, 50);
    self.folderImageView.center = CGPointMake(40, 50);
    [self addSubview:self.folderImageView];
    [self addSubview:self.fileImageView];
    
    // 添加图标名字的Label
    self.iconNameLabel               = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, 80, 20)];
    self.iconNameLabel.font          = [UIFont fontWithName:@"AppleSDGothicNeo-Light" size:12.f];
    self.iconNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.iconNameLabel];
    // 添加文件夹或者文件名的Label
    self.nameLabel      = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 60)];
    self.nameLabel.font = [UIFont fontWithName:@"Avenir-Book" size:12.f];
    [self addSubview:self.nameLabel];
    
    // 按钮必须最后添加，因为最后添加显示在最前面，这样点击就能有效的跳转(可能我这说法不正确，点击事件可能会传递)
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 500, 80)];
    [self.button addTarget:self
                    action:@selector(buttonEvent)
          forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
}

#pragma mark 加载cell的模型对象
- (void)loadContent {
    // 获取File模型对象
    File *file = self.data;
    
    self.nameLabel.text = file.name;
    
    if (file.fileType == kFolder) {
        
        [self changeToFolderState];
        
    } else if (file.fileType == kFile) {
    
        [self changeToFileState];
    }
}

/**
 *  切换到文件夹状态
 */
- (void)changeToFolderState {

    self.fileImageView.hidden    = YES;
    self.folderImageView.hidden  = NO;
    self.iconNameLabel.textColor = [UIColor blackColor];    // 黑色
    self.nameLabel.textColor     = [UIColor blackColor];
    self.iconNameLabel.text      = @"Folder";
}

/**
 *  切换到文件状态
 */
- (void)changeToFileState {

    self.fileImageView.hidden    = NO;
    self.folderImageView.hidden  = YES;
    self.iconNameLabel.textColor = [UIColor grayColor];     // 灰色
    self.nameLabel.textColor     = [UIColor grayColor];
    self.iconNameLabel.text      = @"File";
}

- (void)buttonEvent {
    // hy:按照我的需求：每次点击，就要拿到当前cell的对应的file的模型对象
    // hy:然后根据将file的模型对象传递给下一个控制器，
    // hy:下一个控制器会根据file的模型对象中的存储子file的数组创建所有对应的file
    // hy:所有对应的
    
    File *file = self.data;
    // 根据文件类型，如果是文件夹类型，就跳转
    if (file.fileType == kFolder) {
        // 创建
        FileViewController *fvc = [[FileViewController alloc] init];
        fvc.rootFile            = file;
        [self.controller.navigationController pushViewController:fvc
                                                        animated:YES];
    }
}

@end
