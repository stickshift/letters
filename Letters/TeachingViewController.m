//
//  TeachingViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TeachingViewController.h"

@implementation TeachingViewController

/**
 * Custom setter initializes letterLabel with first letter
 */
- (void) setLetterLabel:(UILabel*)letterLabel
{
    _letterLabel = letterLabel;
    
    if (self.alphabet.count)
    {
        letterLabel.text = self.alphabet[self.currentLetter];
    }
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
    [self.classifier trainFeatures:features generateOutput:self.currentLetter];
    
    // Bump currentLetter
    self.currentLetter = (self.currentLetter + 1) % self.alphabet.count;
    
    // Ask for next letter in alphabet
    self.letterLabel.text = self.alphabet[self.currentLetter];
}

@end
