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

/**
 * Trains classifier with positive example.
 */
- (void) trainFeatures:(NSArray*)features generateOutput:(NSUInteger)output;

/**
 * Trains classifier with negative example.
 */
- (void) trainFeatures:(NSArray*)features doNotGenerateOutput:(NSUInteger)output;

/**
 * Classifies features according to prior training.
 */
- (NSUInteger) classifyFeatures:(NSArray*)features;

@end
