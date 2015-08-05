//
//  LinearGuessClassifierTests.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LettersTestCase.h"
#import "LinearGuessClassifier.h"

@interface LinearGuessClassifierTests : LettersTestCase @end
@implementation LinearGuessClassifierTests

- (void) testClassifyGuessesEachLetterInVocabulary
{
    NSArray* features1 = @[@0, @0, @1];
    NSArray* features2 = @[@0, @1, @0];
    NSArray* features3 = @[@0, @1, @1];
    
    /* Run */
    
    LinearGuessClassifier* classifier = [[LinearGuessClassifier alloc] init];
    [classifier trainFeatures:features1 generateOutput:0];
    [classifier trainFeatures:features2 generateOutput:1];
    [classifier trainFeatures:features3 generateOutput:2];
    
    /* Verify */
    
    // features1 => 0 is right answer
    expect([classifier classifyFeatures:features1]).to.equal(0);
    
    // features2 => 0
    expect([classifier classifyFeatures:features2]).to.equal(0);
    
    [classifier trainFeatures:features2 doNotGenerateOutput:0];
    
    // features2 => 1 is right answer
    expect([classifier classifyFeatures:features2]).to.equal(1);
    
    // features3 => 0
    expect([classifier classifyFeatures:features3]).to.equal(0);
    
    [classifier trainFeatures:features3 doNotGenerateOutput:0];
    
    // features3 => 1
    expect([classifier classifyFeatures:features3]).to.equal(1);
    
    [classifier trainFeatures:features3 doNotGenerateOutput:1];
    
    // features3 => 2 is right answer
    expect([classifier classifyFeatures:features3]).to.equal(2);
}

@end
