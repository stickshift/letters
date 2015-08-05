//
//  TeachingViewControllerTests.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LettersTestCase.h"
#import "TeachingViewController.h"

@interface TeachingViewControllerTests : LettersTestCase @end
@implementation TeachingViewControllerTests

- (void) testSubmitIteratesThroughAllLettersInAlphabet
{
    NSArray* alphabet = @[ @"A", @"B", @"C" ];
    id letterLabel = OCMClassMock([UILabel class]);
    
    /* Expect */

    // Order matters here
    [letterLabel setExpectationOrderMatters:YES];

    // Make sure we iterate through each letter
    OCMExpect([letterLabel setText:alphabet[0]]);
    OCMExpect([letterLabel setText:alphabet[1]]);
    OCMExpect([letterLabel setText:alphabet[2]]);

    // Rinse and repeat
    OCMExpect([letterLabel setText:alphabet[0]]);
    OCMExpect([letterLabel setText:alphabet[1]]);
    OCMExpect([letterLabel setText:alphabet[2]]);
    
    /* Run */
    
    TeachingViewController* viewController = [[TeachingViewController alloc] initWithNibName:nil bundle:nil];
    viewController.alphabet = alphabet;
    viewController.letterLabel = letterLabel;
    
    // Submit the chalkboard over and over to iterate through the letters
    for (NSUInteger i = 0;i < alphabet.count - 1;i++)
    {
        [viewController submit:nil];
    }
    
    // Rinse and repeat to make sure the alphabet repeats
    for (NSUInteger i = 0;i < alphabet.count;i++)
    {
        [viewController submit:nil];
    }
    
    /* Verify */
    
    OCMVerifyAll(letterLabel);
}

- (void) testSubmitTrainsClassifier
{
    NSArray* alphabet = @[ @"A", @"B", @"C" ];
    NSUInteger currentLetter = 2;
    id image = OCMClassMock([UIImage class]);
    id imageView = OCMClassMock([UIImageView class]);
    id features = OCMClassMock([NSArray class]);
    id featureExtractor = OCMProtocolMock(@protocol(FeatureExtractor));
    id classifier = OCMProtocolMock(@protocol(Classifier));
    
    /* Expect */
    
    // Retrieve image
    OCMStub([imageView image]).andReturn(image);
    
    // Extract features
    OCMStub([featureExtractor extract:image]).andReturn(features);
    
    // Training
    OCMExpect([classifier trainFeatures:features generateOutput:currentLetter]);
    
    /* Run */

    TeachingViewController* viewController = [[TeachingViewController alloc] initWithNibName:nil bundle:nil];
    viewController.alphabet = alphabet;
    viewController.currentLetter = currentLetter;
    viewController.imageView = imageView;
    viewController.featureExtractor = featureExtractor;
    viewController.classifier = classifier;

    // Submit drawing
    [viewController submit:nil];

    /* Verify */
    
    OCMVerifyAll(classifier);
}

@end
