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
    [classifier trainFeatures:features1 generateOutput:@"A"];
    [classifier trainFeatures:features2 generateOutput:@"B"];
    [classifier trainFeatures:features3 generateOutput:@"C"];
    
    /* Verify */
    
    // features1 => A is right answer
    expect([classifier classifyFeatures:features1]).to.equal(@"A");
    
    // features2 => A
    expect([classifier classifyFeatures:features2]).to.equal(@"A");
    
    [classifier trainFeatures:features2 doNotGenerateOutput:@"A"];
    
    // features2 => B is right answer
    expect([classifier classifyFeatures:features2]).to.equal(@"B");
    
    // features3 => A
    expect([classifier classifyFeatures:features3]).to.equal(@"A");
    
    [classifier trainFeatures:features3 doNotGenerateOutput:@"A"];
    
    // features3 => B
    expect([classifier classifyFeatures:features3]).to.equal(@"B");
    
    [classifier trainFeatures:features3 doNotGenerateOutput:@"B"];
    
    // features3 => C is right answer
    expect([classifier classifyFeatures:features3]).to.equal(@"C");
}

@end
