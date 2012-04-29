//
//  BFViewController.m
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import "BFViewController.h"

#import "BFFileLoader.h"
#import "BFLoadingDelegate.h"

@interface FileLoadingDelegate : NSObject <BFLoadingDelegate> {
}

- (void)dataFetched:(NSData*)data byLoader:(BFFileLoader*)loader;
@end

@implementation FileLoadingDelegate

- (void)dataFetched:(NSData*)data byLoader:(BFFileLoader*)loader
{
    NSLog(@"Some data loadede: %i", [data length]);
}

@end


@implementation BFViewController

@synthesize testButton;
@synthesize progressBar;
@synthesize progressAndFileInfo;



- (void)dealloc
{
//    [testButton release];
//    [progressBar release];
//    [progressAndFileInfo release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setInitialState];
    [self initHandlers];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Event handlers and Controller lifecycle

- (void)initHandlers
{
    [testButton addTarget:self action:@selector(testButtonTouch:) forControlEvents:UIControlEventTouchDown];
}

- (void)setInitialState
{
    [progressBar setProgress:0.0f];
}

- (IBAction)testButtonTouch:(id)sender
{
    NSLog(@"Touched down!");
    
    BFFileLoader* loader = [[BFFileLoader alloc] init];
    loader.delegate = [[FileLoadingDelegate alloc] init];
    loader.chunkSize = 2;
    [loader openFileWith:@"/tmp/testfile.txt"];
    [loader readFile];
    [loader close];
}

@end
