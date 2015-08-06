//
//  TeachingViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TeachingViewController.h"
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
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.modeSelector.selectedSegmentIndex = 0;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showTutorial];
}

- (void) showTutorial
{
    if (!isRunningTests() && !_playedTutorial)
    {
        _playedTutorial = YES;
        
        [self print:@"Would you like to play a game of letters?" andThen:^{
            [NSThread sleepForTimeInterval:1.0];
            
            [self print:@"First, teach me to draw a letter" andThen:^{
                [NSThread sleepForTimeInterval:1.0];
                
                [self print:@"Then test me and I will guess" andThen:^{
                    [NSThread sleepForTimeInterval:1.0];
                    
                    [self print:@"Let's play!" andThen:^{
                        [NSThread sleepForTimeInterval:1.0];
                        [self erase:nil];
                    }];
                }];
            }];
        }];
    }
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
