//
//  ChalkboardViewControllerTests.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LettersTestCase.h"
#import "ChalkboardViewController.h"

@interface ChalkboardViewControllerTests : LettersTestCase @end
@implementation ChalkboardViewControllerTests

- (void) testTouchesSetsImage
{
    CGRect frame = CGRectMake(0, 0, 320, 568);
    CGRect bounds = CGRectMake(0, 0, 320, 568);
    id imageView = OCMClassMock([UIImageView class]);
    id touch1 = OCMClassMock([UITouch class]);
    id touch2 = OCMClassMock([UITouch class]);
    
    /* Expect */
    
    OCMStub([imageView frame]).andReturn(frame);
    OCMStub([imageView bounds]).andReturn(bounds);
    OCMStub([touch1 locationInView:imageView]).andReturn(CGPointMake(0, 0));
    OCMStub([touch2 locationInView:imageView]).andReturn(CGPointMake(10, 10));

    OCMExpect([imageView setImage:[OCMArg isNotNil]]);
    
    /* Run */
    
    ChalkboardViewController* viewController = [[ChalkboardViewController alloc] initWithNibName:nil bundle:nil];
    viewController.imageView = imageView;
    [viewController view];
    
    [viewController touchesBegan:[NSSet setWithObjects:touch1, nil] withEvent:nil];
    [viewController touchesMoved:[NSSet setWithObjects:touch2, nil] withEvent:nil];
    
    /* Verify */
    
    OCMVerifyAll(imageView);
}

- (void) testEraseClearsImage
{
    id imageView = OCMClassMock([UIImageView class]);
    
    /* Expect */
    
    OCMExpect([imageView setImage:[OCMArg isNil]]);
    
    /* Run */
    
    ChalkboardViewController* viewController = [[ChalkboardViewController alloc] initWithNibName:nil bundle:nil];
    viewController.imageView = imageView;
    [viewController view];
    
    [viewController erase:nil];
    
    /* Verify */
    
    OCMVerifyAll(imageView);
}

@end
