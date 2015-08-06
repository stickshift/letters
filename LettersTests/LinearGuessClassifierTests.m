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
    NSArray* features4 = @[@1, @0, @0];
    
    /* Run */
    
    LinearGuessClassifier* classifier = [[LinearGuessClassifier alloc] init];

    // Train features 1 to 3
    
    [classifier trainFeatures:features1 generateOutput:@"A"];
    [classifier trainFeatures:features2 generateOutput:@"B"];
    [classifier trainFeatures:features3 generateOutput:@"C"];
    
    /* Verify */
    
    // features1 => A
    expect([classifier classifyFeatures:features1]).to.equal(@"A");
    
    // features2 => B
    expect([classifier classifyFeatures:features2]).to.equal(@"B");
    
    // features3 => C
    expect([classifier classifyFeatures:features3]).to.equal(@"C");
    
    // Since we didn't train on 4, classifier should guess until we say it's good

    // features4 => A
    expect([classifier classifyFeatures:features4]).to.equal(@"A");
    
    [classifier trainFeatures:features4 doNotGenerateOutput:@"A"];
    
    // features4 => B
    expect([classifier classifyFeatures:features4]).to.equal(@"B");
    
    [classifier trainFeatures:features4 doNotGenerateOutput:@"B"];
    
    // features4 => C
    expect([classifier classifyFeatures:features4]).to.equal(@"C");

    [classifier trainFeatures:features4 doNotGenerateOutput:@"C"];
    
    // features4 => nil
    expect([classifier classifyFeatures:features4]).to.beNil();
}

@end
