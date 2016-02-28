//
//  FileViewController.h
//  FileSystem
//
//  Created by HeYang on 15/11/8.
//  Copyright © 2015年 HeYang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "File.h"

@interface FileViewController : UIViewController

/**
 *  根节点
 */
@property (nonatomic, strong) File  *rootFile;

@end
