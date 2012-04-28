//
//  BFFileLoader.h
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFFileLoader : NSObject
{
  @private 
    NSFileHandle* fileHandle;
  
}

#define EXISTED_FILEPATH @"/tmp/testfile.txt"

-(id) init;

-(void) openFileBy:(NSString*)path;
-(void) close;

@end
