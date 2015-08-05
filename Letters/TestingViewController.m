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

/**
 * @see ChalkboardViewController.h
 */
- (IBAction) submit:(id)sender
{
    [super submit:sender];
    
    // Animate the drawing down to targetDrawingArea
    [UIView animateWithDuration:0.5 animations:^{
    
        self.imageView.frame = self.targetDrawingArea.frame;

    } completion:^(BOOL finished) {
        
        if (!self.classifier.vocabulary.count)
        {
            [self print:@"No idea! You haven't taught me anything yet." andThen:nil];
            return;
        }

        NSString* guess = [self classify];
        
        [self print:[NSString stringWithFormat:@"Is it a %@?", guess] andThen:nil];
        
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
    self.currentGuessIndex = [self.classifier classifyFeatures:features];
    _currentGuess = self.classifier.vocabulary[self.currentGuessIndex];
    
    return self.currentGuess;
}

/**
 * @see TestingViewController.h
 */
- (IBAction) tryAgain:(id)sender
{
    // Tell the classifier this guess was wrong
    NSArray* features = [self.featureExtractor extract:self.imageView.image];
    [self.classifier trainFeatures:features doNotGenerateOutput:self.currentGuessIndex];
    
    // Try again
    [self submit:sender];
}

@end
