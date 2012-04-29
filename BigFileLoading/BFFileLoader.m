//
//  BFFileLoader.m
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import "BFFileLoader.h"
#import "BFLoadingDelegate.h"

@implementation BFFileLoader 

@synthesize delegate;
@synthesize chunkSize=_chunkSize;

@synthesize fileSize=_fileSize;
@synthesize filePosition=_filePosition;

- (void) setChunkSize:(NSUInteger)chunkSize 
{
    if (chunkSize == 0) {
        [NSException raise:@"Chunk size must not be 0!" format:@""];
    }
    _chunkSize = chunkSize;
}

-(NSUInteger) getFileSizeFor:(NSString*)filepath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filepath error:NULL];
    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    if (fileSizeNumber) {
        NSUInteger size = [fileSizeNumber unsignedLongLongValue];
        NSLog(@"File size: %i\n", size);
        return size;
    } else {
        return 0;
    }
}

- (void)openFileWith:(NSString*)filepath
{
    _fileSize = [self getFileSizeFor:filepath];
    
    fileHandle = [NSFileHandle fileHandleForReadingAtPath:filepath];
    if (!_fileSize) {
        [NSException raise:@"Unable to open file" format:@"File %s is unaccessible", filepath];
    }
}

- (void)readFile
{
    if (!fileHandle) {
        [NSException raise:@"File must be opened." format:@""];
    }
    
    if (!delegate) {
        [NSException raise:@"Delegate must be set!" format:@""];
    }
    
    while (true) {
        @autoreleasepool {
            NSData* dataRead = [fileHandle readDataOfLength:_chunkSize];
            if ([dataRead length] == 0 || !dataRead) {
                break;
            }
            _filePosition = [fileHandle offsetInFile];
            NSLog(@"Bytes read %d", [dataRead length]);    
            [delegate dataFetched:dataRead byLoader:self];
        }
    }
    
    NSLog(@"File successfully read");
}

- (void)close
{
    [fileHandle closeFile];
}

- (id)init
{
    self = [super init];
    return self;
}


@end

