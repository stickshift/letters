//
//  TestViewController.m
//  Letters
//
//  Created by Andrew Young on 7/31/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ConsoleViewController.h"
#import "TestViewController.h"

@interface TestViewController()

@property BOOL guessing;
@property ConsoleViewController* consoleViewController;

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
    
    self.consoleViewController = [[ConsoleViewController alloc] initWithNibName:@"ConsoleView"
                                                                         bundle:[NSBundle mainBundle]];
    [self addChildViewController:self.consoleViewController];
    
    self.consoleViewController.view.frame = self.imageView.frame;
    self.consoleViewController.view.hidden = YES;
    [self.view insertSubview:self.consoleViewController.view atIndex:0];

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
    // Animate the drawing out of the way and hide the submit and erase buttons
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = self.chalkboardView.frame;
    } completion:^(BOOL finished) {
        [self guess];
    }];
}

- (void) guess
{
    self.guessing = YES;

    self.eraseButton.hidden = YES;
    self.submitButton.hidden = YES;
    self.youGotItButton.hidden = NO;
    self.youGotItButton.enabled = NO;
    self.tryAgainButton.hidden = NO;
    self.tryAgainButton.enabled = NO;
    
    // Make a guess and then show You got it / Try again buttons
    Script* script = [[Script alloc] init];
    [script addLine:@"Hmmmm"];
    [script addLine:@"Is it an A?"];
    
    self.consoleViewController.view.hidden = NO;
    [self.consoleViewController play:script andThen:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.youGotItButton.enabled = YES;
            self.tryAgainButton.enabled = YES;
        });
    }];
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
    [self.consoleViewController clear];
    self.youGotItButton.enabled = NO;
    self.tryAgainButton.enabled = NO;
    
    Script* script = [[Script alloc] init];
    [script addLine:@"How about a B?"];
    
    [self.consoleViewController play:script andThen:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.youGotItButton.enabled = YES;
            self.tryAgainButton.enabled = YES;
        });
    }];
}

- (IBAction) youGotIt:(id)sender
{
    self.guessing = NO;

    [self.consoleViewController clear];
    self.consoleViewController.view.hidden = YES;

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
