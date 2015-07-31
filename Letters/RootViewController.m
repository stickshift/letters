//
//  RootViewController.m
//  Letters
//
//  Created by Andrew Young on 7/31/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "RootViewController.h"
#import "ConsoleViewController.h"
#import "ChalkboardViewController.h"

@interface RootViewController ()

@property ConsoleViewController* consoleViewController;
@property ChalkboardViewController* chalkboardViewController;

@end

@implementation RootViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.consoleViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"consoleViewController"];
    [self addChildViewController:self.consoleViewController];
    [self.view addSubview:self.consoleViewController.view];
    
    self.chalkboardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"chalkboardViewController"];
    [self addChildViewController:self.chalkboardViewController];
    [self.view addSubview:self.chalkboardViewController.view];    
}

@end
