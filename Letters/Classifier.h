//
//  Classifier.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A protocol that defines interface for classifier algorithms.
 */
@protocol Classifier <NSObject>

/** The set of letters we have been trained on */
@property (strong, nonatomic) NSArray* vocabulary;

/**
 * Trains classifier with positive example.
 */
- (void) trainFeatures:(NSArray*)features generateOutput:(NSString*)output;

/**
 * Trains classifier with negative example.
 */
- (void) trainFeatures:(NSArray*)features doNotGenerateOutput:(NSString*)output;

/**
 * Classifies features according to prior training.
 */
- (NSString*) classifyFeatures:(NSArray*)features;

@end
