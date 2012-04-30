//
//  BFLoadingDelegate.h
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 29.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BFFileLoader;
@class BFOperation;

@protocol BFLoadingDelegate <NSObject>

- (void)beforeLoading;
- (void)dataFetched:(NSData*)data inOperation:(BFOperation*)operation;
- (void)afterLoading;

@end
