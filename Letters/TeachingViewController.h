//
//  TeachingViewController.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ChalkboardViewController.h"
#import "FeatureExtractor.h"
#import "Classifier.h"

/**
 * Manages "teaching" interaction —
 *
 *   1) Joshua asks you to teach him a letter
 *   2) You draw it with your finger and tell Joshua when you're done
 *   3) Joshua remembers this as a positive example
 */
@interface TeachingViewController : ChalkboardViewController

/** The set of letters to teach */
@property (strong, nonatomic) NSArray* alphabet;

/** Lets you set entire alphabet at once using IB and user-defined runtime props */
@property (strong, nonatomic) NSString* alphabetValues;

/** Index of currently selected letter from alphabet */
@property NSUInteger currentLetter;

/** The label used to display the current letter */
@property (weak, nonatomic) IBOutlet UILabel* letterLabel;

/** The feature extraction algorithm used to process the drawings */
@property (strong, nonatomic) NSObject<FeatureExtractor>* featureExtractor;

/** The classification algorithm used to recognize the drawings */
@property (strong, nonatomic) NSObject<Classifier>* classifier;

@end
