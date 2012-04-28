//
//  BFFileLoader.m
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import "BFFileLoader.h"

@implementation BFFileLoader 

-(void) openFileBy:(NSString*)path
{
    self->fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    if (self->fileHandle == nil) {
        [NSException raise:@"Unable to open file" format:@"file %s unaccessible", path];
    }
}

-(NSData*) readChunk:(NSUInteger) size 
{
    NSData* dataRead = [self->fileHandle readDataOfLength:size];
    NSLog(@"bytes read %d", [dataRead length]);
    return dataRead;
}

-(void) close
{
    [self->fileHandle closeFile];
}

-(id) init
{
    self = [super init];
    return self;
}

@end

