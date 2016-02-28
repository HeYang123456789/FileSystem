//
//  File.m
//  FileSystem
//
//  Created by HeYang on 15/11/8.
//  Copyright © 2015年 HeYang. All rights reserved.
//

#import "File.h"

@interface File ()

@property (nonatomic, strong) NSMutableArray <File *>  *childFiles;

@end

@implementation File

- (instancetype)init {
    
    self = [super init];
    if (self) {
    
        self.childFiles = [NSMutableArray array];
    }
    
    return self;
}

- (void)addFile:(File *)file {

    NSParameterAssert(file);
    [self.childFiles addObject:file];
}

+ (instancetype)fileWithFileType:(EFile)fileType fileName:(NSString *)name {

    File *file    = [[[self class] alloc] init];
    file.fileType = fileType;
    file.name     = name;
    
    return file;
}

@end
