//
//  TestingViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LettersTestCase.h"
#import "TestingViewController.h"

@interface TestingViewControllerTests : LettersTestCase @end
@implementation TestingViewControllerTests

- (void) testClassify
{
    id image = OCMClassMock([UIImage class]);
    id imageView = OCMClassMock([UIImageView class]);
    id features = OCMClassMock([NSArray class]);
    id featureExtractor = OCMProtocolMock(@protocol(FeatureExtractor));
    id classifier = OCMProtocolMock(@protocol(Classifier));
    NSUInteger expectedResult = 2;
    NSArray* vocabulary = @[ @"A", @"B", @"C" ];
    
    /* Expect */
    
    // Retrieve image
    OCMStub([imageView image]).andReturn(image);
    
    // Extract features
    OCMStub([featureExtractor extract:image]).andReturn(features);
    
    // Classify
    OCMStub([classifier classifyFeatures:features]).andReturn(expectedResult);
    
    // Specify vocabulary
    OCMStub([classifier vocabulary]).andReturn(vocabulary);
    
    /* Run */

    TestingViewController* viewController = [[TestingViewController alloc] initWithNibName:nil bundle:nil];
    viewController.imageView = imageView;
    viewController.featureExtractor = featureExtractor;
    viewController.classifier = classifier;
    [viewController view];
    
    /* Verify */
    
    expect([viewController classify]).to.equal(@"C");
}

- (void) testSubmitAnimatesDrawingDownToChalkboardSize
{
    CGRect targetDrawingAreaFrame = CGRectMake(10, 10, 100, 100);
    id targetDrawingArea = OCMClassMock([UIView class]);
    id imageView = OCMClassMock([UIImageView class]);
    
    /* Expect */
    
    OCMStub([targetDrawingArea frame]).andReturn(targetDrawingAreaFrame);
    
    OCMExpect([imageView setFrame:targetDrawingAreaFrame]);
    
    /* Run */

    TestingViewController* viewController = [[TestingViewController alloc] initWithNibName:nil bundle:nil];
    viewController.imageView = imageView;
    viewController.targetDrawingArea = targetDrawingArea;
    [viewController view];

    [viewController submit:nil];
    
    /* Verify */
    
    OCMVerifyAll(imageView);
}

- (void) testSubmitGuessesAnswer
{
    NSArray* vocabulary = @[ @"A", @"B", @"C" ];
    id classifier = OCMProtocolMock(@protocol(Classifier));
    TestingViewController* viewController = OCMPartialMock([[TestingViewController alloc] initWithNibName:nil bundle:nil]);
    
    /* Expect */

    OCMStub([classifier vocabulary]).andReturn(vocabulary);
    
    OCMStub([viewController classify]).andReturn(@"A");
    
    OCMExpect([viewController print:@"Is it a A?" andThen:[OCMArg any]]);
    
    /* Run */
    
    viewController.classifier = classifier;
    [viewController view];
    
    [viewController submit:nil];
    
    /* Verify */
    
    OCMVerifyAllWithDelay((id)viewController, 15);
}

- (void) testTryAgain
{
    NSUInteger currentGuessIndex = 2;
    id image = OCMClassMock([UIImage class]);
    id imageView = OCMClassMock([UIImageView class]);
    id features = OCMClassMock([NSArray class]);
    id featureExtractor = OCMProtocolMock(@protocol(FeatureExtractor));
    id classifier = OCMProtocolMock(@protocol(Classifier));
    TestingViewController* viewController = OCMPartialMock([[TestingViewController alloc] initWithNibName:nil bundle:nil]);

    /* Expect */
    
    // Retrieve image
    OCMStub([imageView image]).andReturn(image);
    
    // Extract features
    OCMStub([featureExtractor extract:image]).andReturn(features);
    
    // Training with negative example
    OCMExpect([classifier trainFeatures:features doNotGenerateOutput:currentGuessIndex]);
    
    // Re-submit
    OCMExpect([viewController submit:[OCMArg any]]);
    
    /* Run */
    
    viewController.currentGuessIndex = currentGuessIndex;
    viewController.imageView = imageView;
    viewController.featureExtractor = featureExtractor;
    viewController.classifier = classifier;
    [viewController view];
    
    // Tell viewController the currentGuess is wrong
    [viewController tryAgain:nil];
    
    /* Verify */
    
    OCMVerifyAll(classifier);
    OCMVerifyAll((id)viewController);
}

@end
