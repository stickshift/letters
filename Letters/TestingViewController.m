//
//  TestingViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TestingViewController.h"

@interface TestingViewController()

@property (weak, nonatomic) IBOutlet UISegmentedControl* modeSelector;

@end

@implementation TestingViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.hidden = YES;
    self.tryAgainButton.hidden = YES;
    self.youGotItButton.hidden = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.modeSelector.selectedSegmentIndex = 1;
}

- (IBAction)toggleModes:(id)sender
{
    self.tabBarController.selectedIndex = self.modeSelector.selectedSegmentIndex;
}

- (IBAction) erase:(id)sender
{
    // Make sure chalkboard controls are visible
    self.eraseButton.hidden = NO;
    self.submitButton.hidden = NO;

    [super erase:sender];
}

/**
 * @see ChalkboardViewController.h
 */
- (IBAction) submit:(id)sender
{
    [super submit:sender];
    
    // Hide chalkboard controls
    self.eraseButton.hidden = YES;
    self.submitButton.hidden = YES;
    
    // Animate the drawing down to targetDrawingArea
    [UIView animateWithDuration:0.5 animations:^{
    
        self.imageView.frame = self.targetDrawingArea.frame;

    } completion:^(BOOL finished) {
        
        NSString* guess = [self classify];
        
        if (guess == nil)
        {
            [self print:@"I'm out of guesses!" andThen:^{
                [NSThread sleepForTimeInterval:0.5];
                [self erase:self];
            }];
        }
        
        else
        {
            [self print:[NSString stringWithFormat:@"Is it a %@?", guess] andThen:^{
                self.tryAgainButton.hidden = NO;
                self.youGotItButton.hidden = NO;
            }];
        }
    }];
}

/**
 * @see TestingViewController.h
 */
- (NSString*) classify
{
    if (!self.classifier.vocabulary.count)
    {
        return nil;
    }
    
    // Extract features
    NSArray* features = [self.featureExtractor extract:self.imageView.image];
    
    // Classify them
    self.currentGuess = [self.classifier classifyFeatures:features];
    
    return self.currentGuess;
}

/**
 * @see TestingViewController.h
 */
- (IBAction) tryAgain:(id)sender
{
    // Hide feedback controls
    self.tryAgainButton.hidden = YES;
    self.youGotItButton.hidden = YES;
    self.textView.hidden = YES;

    // Tell the classifier this guess was wrong
    NSArray* features = [self.featureExtractor extract:self.imageView.image];
    [self.classifier trainFeatures:features doNotGenerateOutput:self.currentGuess];
    
    // Try again
    [self submit:sender];
}

/**
 * @see TestingViewController.h
 */
- (IBAction) youGotIt:(id)sender
{
    // Hide feedback controls
    self.tryAgainButton.hidden = YES;
    self.youGotItButton.hidden = YES;
    self.textView.hidden = YES;
    
    [self erase:sender];
}

@end
