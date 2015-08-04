//
//  TestViewController.m
//  Letters
//
//  Created by Andrew Young on 7/31/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController()

@property (weak, nonatomic) IBOutlet UISegmentedControl* modeSelector;

@end

@implementation TestViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.modeSelector.selectedSegmentIndex = 1;
}

- (IBAction) toggleModes:(id)sender
{
    self.tabBarController.selectedIndex = self.modeSelector.selectedSegmentIndex;
}

@end
