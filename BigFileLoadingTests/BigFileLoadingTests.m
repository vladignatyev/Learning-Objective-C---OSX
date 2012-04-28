//
//  BigFileLoadingTests.m
//  BigFileLoadingTests
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import "BigFileLoadingTests.h"

@implementation BigFileLoadingTests

- (void)setUp
{
    [super setUp];
    
    self->fileLoader = [[BFFileLoader alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInitialConditions
{
    STAssertNotNil(self->fileLoader, @"BFFileLoader object must be not nil");
    STAssertNoThrow([self->fileLoader openFileBy:EXISTED_FILEPATH], @"Open file must not raise error");  
}

- (void)testDataNotNil
{
    [self->fileLoader openFileBy:EXISTED_FILEPATH];

//    STAssertTrue([self->fileLoader->fileData length] > 0, @"Length of data must not be null");
}

@end
