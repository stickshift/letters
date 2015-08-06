//
//  LinearGuessClassifier.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LinearGuessClassifier.h"

@interface LinearGuessClassifier()
{
    NSMutableArray* _vocabulary;
    NSMutableDictionary* _negativeExampleMap;
}
@end

@implementation LinearGuessClassifier
@synthesize vocabulary = _vocabulary;

/**
 * Ctor
 */
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _vocabulary = [NSMutableArray array];
        _negativeExampleMap = [NSMutableDictionary dictionary];
    }
    return self;
}

/**
 * @see Classifier.h
 */
- (void) trainFeatures:(NSArray*)features generateOutput:(NSString*)output
{
    if (![_vocabulary containsObject:output])
    {
        [_vocabulary addObject:output];
    }
}

/**
 * @see Classifier.h
 */
- (void) trainFeatures:(NSArray*)features doNotGenerateOutput:(NSString*)output
{
    NSMutableArray* negativeExamples = _negativeExampleMap[features];
    if (negativeExamples == nil)
    {
        negativeExamples = [NSMutableArray array];
        _negativeExampleMap[features] = negativeExamples;
    }
    
    if (![negativeExamples containsObject:output])
    {
        [negativeExamples addObject:output];
    }
}

/**
 * @see Classifier.h
 */
- (NSString*) classifyFeatures:(NSArray*)features
{
    NSMutableArray* negativeExamples = _negativeExampleMap[features];

    for (NSString* s in _vocabulary)
    {
        if (![negativeExamples containsObject:s])
        {
            return s;
        }
    }

    return nil;
}

@end
