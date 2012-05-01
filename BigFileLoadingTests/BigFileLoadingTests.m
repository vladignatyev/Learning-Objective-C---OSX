//
//  BigFileLoadingTests.m
//  BigFileLoadingTests
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import "BigFileLoadingTests.h"

@implementation BigFileLoadingTests


#define EXISTING_FILEPATH @"/tmp/testfile.txt"
#define NONEXISTING_FILEPATH @"/tmp/realynonexistingfileforBFFileLoader"
#define MINIMAL_CHUNK_SIZE 5

- (void)setUp
{
    [super setUp];
    
    fileLoader = [[BFFileLoader alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInitialConditions
{
    STAssertNotNil(fileLoader, @"BFFileLoader object must be not nil");
    STAssertThrows([fileLoader openFile:NONEXISTING_FILEPATH], @"Open file must throw exception on non existing file");
    STAssertNoThrow([fileLoader openFile:EXISTING_FILEPATH], @"Open file must not raise error");  
}

- (void)testDataNotNilOnRead
{
//    [fileLoader openFileWith:EXISTING_FILEPATH];
    
//    STAssertNotNil(data, @"data must not be null if we read chunk from existing file");
    
}


@end
