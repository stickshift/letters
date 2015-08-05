//
//  TeachingViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TeachingViewController.h"

@implementation TeachingViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.letterLabel.text = self.alphabet[self.currentLetter];
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
    [self.classifier trainFeatures:features generateOutput:self.currentLetter];
    
    // Bump currentLetter
    self.currentLetter = (self.currentLetter + 1) % self.alphabet.count;
    
    // Ask for next letter in alphabet
    self.letterLabel.text = self.alphabet[self.currentLetter];
}

@end
