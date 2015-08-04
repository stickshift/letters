//
//  TeachViewControllerTests.m
//  Letters
//
//  Created by Andrew Young on 8/3/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "LettersTestCase.h"
#import "TeachViewController.h"

@interface TeachViewControllerTests : LettersTestCase @end
@implementation TeachViewControllerTests

- (void) testSubmitParsesPatternAndPassesToClassifer
{
    NSArray* pattern = [NSArray array];
    NSUInteger currentLetter = 0;
    id patternParser = OCMClassMock([PatternParser class]);
    id classifier = OCMClassMock([Classifier class]);
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    TeachViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:@"teachViewController"];

    /* Setup */
    
    viewController.currentLetter = currentLetter;
    viewController.patternParser = patternParser;
    viewController.classifier = classifier;
    
    /* Expectations */
    
    // Parsing any input image returns pattern
    OCMStub([patternParser parse:[OCMArg any]]).andReturn(pattern);

    // Expect pattern is then passed to classifier
    OCMExpect([classifier trainInput:pattern generatesOutput:currentLetter]);
    
    /* Execute */
    
    [viewController submit:self];
    
    /* Verify */
    
    OCMVerifyAll(classifier);
}

@end
