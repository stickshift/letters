//
//  LinearGuessClassifier.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Classifier.h"

/**
 * A very simple Classifier that just guesses any of the characters it's seen
 */
@interface LinearGuessClassifier : NSObject<Classifier>

/**
 * @see Classifier.h
 */
- (void) trainFeatures:(NSArray*)features generateOutput:(NSString*)output;

/**
 * @see Classifier.h
 */
- (void) trainFeatures:(NSArray*)features doNotGenerateOutput:(NSString*)output;

/**
 * @see Classifier.h
 */
- (NSString*) classifyFeatures:(NSArray*)features;

@end
