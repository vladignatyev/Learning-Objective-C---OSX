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
    BFViewController* viewController;
}

- (id)initWithViewController:(BFViewController*)aViewController;
@end

@implementation FileLoadingDelegate

- (void)beforeLoading
{
    
}

- (void)afterLoading
{
    
}

- (void)dataFetched:(NSData*)data inOperation:(BFOperation *)operation
{
    [self performSelectorOnMainThread:@selector(updateView:) withObject:operation waitUntilDone:TRUE];
}

- (void)updateView:(BFOperation*)operation
{
    float progressValue = (float) [operation filePosition] / (float) [operation fileSize];
    [viewController.progressBar setProgress:progressValue];
    if (progressValue == 1) {
        [viewController.progressAndFileInfo setText:@"Файл загружен"];        
    } else {
        [viewController.progressAndFileInfo setText:@"Файл загружается"];        
    }
}

- (id)initWithViewController:(BFViewController*)aViewController
{
    self = [super init];
    
    viewController = aViewController;
    
    return self;
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

#define KB 1024
#define MB 1024*KB

- (IBAction)testButtonTouch:(id)sender
{
    [progressAndFileInfo setText:@"Файл еще не загружен"];        
    [progressBar setProgress:0.0f];
    
    BFFileLoader* loader = [[BFFileLoader alloc] init];
    loader.delegate = [[FileLoadingDelegate alloc] initWithViewController:self];
    loader.chunkSize = 10*MB;    //1 MB chunks
    NSString* path = [[NSBundle mainBundle] pathForResource:@"bigfile" ofType:@"dat"];
    [loader openFile:path]; //any large file
    [loader readFile: YES];
}

@end
