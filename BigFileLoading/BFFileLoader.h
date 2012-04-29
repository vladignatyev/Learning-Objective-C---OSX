//
//  BFFileLoader.h
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFLoadingDelegate.h"

@interface BFFileLoader : NSObject
{
  @private 
    NSFileHandle* fileHandle;
    NSUInteger currentChunkNumber;
    NSUInteger _chunkSize;
    NSUInteger _fileSize;
    NSUInteger _filePosition;
}

@property (nonatomic,retain,readwrite) id < BFLoadingDelegate > delegate;

@property (nonatomic,setter = setChunkSize:, readwrite) NSUInteger chunkSize;
- (void) setChunkSize:(NSUInteger)chunkSize;

@property (nonatomic,assign,readonly) NSUInteger filePosition;
@property (nonatomic,assign,readonly) NSUInteger fileSize;


- (void)openFileWith:(NSString*)path;
- (void)readFile;
- (void)close;
- (id)init;

@end
