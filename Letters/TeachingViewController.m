//
//  TeachingViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TeachingViewController.h"
#import "SampleGridFeatureExtractor.h"
#import "SampleGridViewController.h"
#import "Utils.h"

@interface TeachingViewController()
{
    BOOL _playedTutorial;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl* modeSelector;

@end

@implementation TeachingViewController

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.textView.hidden = YES;
    self.letterLabel.text = self.alphabet[self.currentLetter];
    
    // Load sample grid visualization
    if ([self.featureExtractor isKindOfClass:[SampleGridFeatureExtractor class]])
    {
        SampleGridViewController* gridViewController = [[SampleGridViewController alloc] initWithNibName:@"SampleGridView"
                                                                                                  bundle:[NSBundle mainBundle]];
        gridViewController.featureExtractor = (SampleGridFeatureExtractor*)self.featureExtractor;
        
        [self addChildViewController:gridViewController];
        [self.view addSubview:gridViewController.view];
        gridViewController.view.frame = self.imageView.frame;
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.modeSelector.selectedSegmentIndex = 0;
}

- (IBAction)toggleModes:(id)sender
{
     self.tabBarController.selectedIndex = self.modeSelector.selectedSegmentIndex;
}

/**
 * Custom setter for alphabetValues that parses out the alphabet
 */
- (void) setAlphabetValues:(NSString*)alphabetValues
{
    _alphabetValues = alphabetValues;
    self.alphabet = [alphabetValues componentsSeparatedByString:@", "];
}

/**
 * @see ChalkboardViewController.h
 */
- (IBAction)submit:(id)sender
{
    [super submit:sender];
    
    if (!self.alphabet.count)
    {
        return;
    }
    
    // Extract features
    NSArray* features = [self.featureExtractor extract:self.imageView.image];
    
    // Train classifier with positive example
    [self.classifier trainFeatures:features generateOutput:self.alphabet[self.currentLetter]];
    
    // Erase board
    [self erase:self];
    
    // Bump currentLetter
    self.currentLetter = (self.currentLetter + 1) % self.alphabet.count;
    
    // Ask for next letter in alphabet
    self.letterLabel.text = self.alphabet[self.currentLetter];
}

@end
