//
//  TestViewController.m
//  Letters
//
//  Created by Andrew Young on 7/31/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController()

@property BOOL guessing;

@property (weak, nonatomic) IBOutlet UISegmentedControl* modeSelector;
@property (weak, nonatomic) IBOutlet UIView* chalkboardView;

@property (weak, nonatomic) IBOutlet UIButton* eraseButton;
@property (weak, nonatomic) IBOutlet UIButton* submitButton;
@property (weak, nonatomic) IBOutlet UIButton* youGotItButton;
@property (weak, nonatomic) IBOutlet UIButton* tryAgainButton;

@end

@implementation TestViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.youGotItButton.hidden = YES;
    self.tryAgainButton.hidden = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.modeSelector.selectedSegmentIndex = 1;
}

- (IBAction) toggleModes:(id)sender
{
    self.tabBarController.selectedIndex = self.modeSelector.selectedSegmentIndex;
}

/**
 * @see ChalkboardViewController.h
 */
- (IBAction) submit:(id)sender
{
    // Animate the drawing out of the way
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = self.chalkboardView.frame;
        
        // Swap buttons
        self.eraseButton.hidden = YES;
        self.submitButton.hidden = YES;
        self.youGotItButton.hidden = NO;
        self.tryAgainButton.hidden = NO;
    }];
    
    self.guessing = YES;
}

/**
 * Disables drawing when guessing is true
 */
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.guessing)
    {
        return;
    }
    
    [super touchesMoved:touches withEvent:event];
}

- (IBAction) tryAgain:(id)sender
{
}

- (IBAction) youGotIt:(id)sender
{
    self.guessing = NO;
    [self erase:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        // Swap buttons
        self.eraseButton.hidden = NO;
        self.submitButton.hidden = NO;
        self.youGotItButton.hidden = YES;
        self.tryAgainButton.hidden = YES;
    }];
}

@end
