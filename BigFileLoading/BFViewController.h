//
//  BFViewController.h
//  BigFileLoading
//
//  Created by Владимир Игнатьев on 28.04.12.
//  Copyright (c) 2012  ya.na.pochte@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFViewController : UIViewController
{
    UIButton *testButton;
    UILabel *progressAndFileInfo;
    UIProgressView *progressBar;
}

@property (nonatomic, retain) IBOutlet UIButton *testButton;
@property (nonatomic, retain) IBOutlet UILabel *progressAndFileInfo;
@property (nonatomic, retain) IBOutlet UIProgressView *progressBar;

- (void)setInitialState;
- (void)initHandlers;
- (IBAction)testButtonTouch:(id)sender;

@end
