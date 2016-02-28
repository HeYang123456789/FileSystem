//
//  FileCell.h
//  CompositePattern
//
//  Created by HeYang on 15/10/20.
//  Copyright © 2015年 ZiPeiYi. All rights reserved.
//

/**
 *  一个需求：
 *      如果是多种文件，点击按钮触发按钮事件，就需要调用系统软件来打开文件进行查看。
 *      那么这个点击触发事件就需要添加很多种判断语句了，根据什么类型来进行操作
 *      判断语句太多了就不太好，所以这里就需要更改设计模式了，那么该使用什么设计模式呢？
 */
/**
 *  一个需求：
 *      FileCell上面需要再加两个Label显示一下内部的"文件数量"和"文件夹数量"
 */

#import <UIKit/UIKit.h>

@interface FileCell : UITableViewCell

/**
 *  都用weak避免循环引用
 */

// 建议这个data类型限定为<File *>
// FileCell需要这个file模型对象加载当前的FileCell
@property (nonatomic, weak) id                data;

@property (nonatomic, weak) NSIndexPath      *indexPath;
@property (nonatomic, weak) UITableView      *tableView;
@property (nonatomic, weak) UIViewController *controller;

- (void)loadContent;

@end
