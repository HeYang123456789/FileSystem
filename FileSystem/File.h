//
//  File.h
//  FileSystem
//
//  Created by HeYang on 15/11/8.
//  Copyright © 2015年 HeYang. All rights reserved.
//

/**
 *  这个File相当于一个File模型，不同于模型的地方是 这个File类多了些操作
 *  存储文件的属性：
 *      文件类型、文件(夹)名、文件子集合、文件子集合的子文件个数和子文件夹个数
 */

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    
    kFile,   // 文件
    kFolder, // 文件夹
    
} EFile;

@interface File : NSObject

/**
 *  文件夹或者文件的名字,根据EFile类别来区分
 */
@property (nonatomic, strong) NSString *name;

/**
 *  文件类型
 */
@property (nonatomic) EFile             fileType;

/**
 *  子文件集合
 */
@property (nonatomic, strong, readonly) NSMutableArray <File *>  *childFiles;

/**
 *  添加文件
 *
 *  @param file 文件
 */
- (void)addFile:(File *)file;

/**
 *  便利构造器
 *
 *  @param fileType 文件类型
 *  @param name     文件名字
 *
 *  @return 文件对象
 */
+ (instancetype)fileWithFileType:(EFile)fileType fileName:(NSString *)name;

@end
