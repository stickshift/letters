//
//  TestingViewController.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ChalkboardViewController.h"
#import "FeatureExtractor.h"
#import "Classifier.h"

/**
 * Manages "testing" interaction -
 *
 *   1) You draw a letter with your finger and tell Joshua when you're done
 *   2) Joshua make a best guess based on what you taught him
 *   3) If he's right, the game repeats
 *   4) If he's wrong, Joshua learns this as a negative example for his guess and tries again
 */
@interface TestingViewController : ChalkboardViewController

/** Defines the drawing area where the target drawing is displayed while we guess */
@property (weak, nonatomic) IBOutlet UIView* targetDrawingArea;

/** Current guess */
@property (strong, readonly) NSString* currentGuess;

/** Index of currently selected guess from vocabulary */
@property NSUInteger currentGuessIndex;

/** The feature extraction algorithm used to process the drawings */
@property (strong, nonatomic) NSObject<FeatureExtractor>* featureExtractor;

/** The classification algorithm used to recognize the drawings */
@property (strong, nonatomic) NSObject<Classifier>* classifier;

/**
 * Guesses the letter based on current image
 */
- (NSString*) classify;

/**
 * Tells us the current guess is wrong and to try again.
 */
- (IBAction) tryAgain:(id)sender;

@end
