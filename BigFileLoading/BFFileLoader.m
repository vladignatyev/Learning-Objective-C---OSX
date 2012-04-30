//
//  BFFileLoader.m
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import "BFFileLoader.h"
#import "BFLoadingDelegate.h"

@implementation BFOperation

@synthesize fileSize = _fileSize;
@synthesize filePosition = _filePosition;
@synthesize filePath = _filePath;

- (void)run
{
    fileHandle = [NSFileHandle fileHandleForReadingAtPath:_filePath];
    while (true) {
        @autoreleasepool {
            NSData* dataRead = [fileHandle readDataOfLength:1024];
            if ([dataRead length] == 0 || !dataRead) {
                break;
            }
            _filePosition = [fileHandle offsetInFile];
            NSLog(@"Bytes read %d", [dataRead length]);    
            [delegate dataFetched:dataRead inOperation:self];
        }
    }
}

- (id)initWithFilePath:(NSString*)path size:(NSUInteger)size andDelegate:(id <BFLoadingDelegate>) aDelegate
{
    self = [super init];
    _filePath = [[NSString alloc]initWithString:path];
    _fileSize = size;
    delegate = aDelegate;
    return self;
}
@end



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

- (void)openFile:(NSString*)filepath
{
    _filepath = [[NSString alloc] initWithString:filepath];
    _fileSize = [self getFileSizeFor:filepath];
    
    if (_fileSize == 0) {
        [NSException raise:@"Unable to open file" format:@"File %s is unaccessible", filepath];
    }
}

- (void)readFile:(BOOL)inAsyncMode
{
    if (!delegate) {
        [NSException raise:@"Delegate must be set!" format:@""];
    }
    
    BFOperation* operation = [[BFOperation alloc]initWithFilePath:_filepath size:_fileSize andDelegate:delegate];
    if (inAsyncMode == YES) {
        [self performSelectorInBackground:@selector(runDelegate:) withObject:operation];        
    } else {
        [operation run];        
    }
}
     
- (void)runDelegate:(BFOperation*)operation
{
    [operation run];
}

//todo: implement this!
- (void)close
{
}

@end

