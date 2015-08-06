//
//  ConsoleViewControllerTests.m
//  Letters
//
//  Created by Andrew Young on 8/4/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LettersTestCase.h"
#import "ConsoleViewController.h"

@interface ConsoleViewControllerTests : LettersTestCase @end
@implementation ConsoleViewControllerTests

/**
 * Prints a message to console and verifies it makes it on the screen.
 */
- (void) testPrintDolesOutCharactersOneAtATime
{
    NSString* msg = @"Hello";
    NSString* cursor = [ConsoleViewController cursor];
    id textView = OCMClassMock([UITextView class]);
    
    /* Expect */
    
    OCMExpect([textView setText:([NSString stringWithFormat:@"%@%@", @"H", cursor])]);
    OCMExpect([textView setText:([NSString stringWithFormat:@"%@%@", @"He", cursor])]);
    OCMExpect([textView setText:([NSString stringWithFormat:@"%@%@", @"Hel", cursor])]);
    OCMExpect([textView setText:([NSString stringWithFormat:@"%@%@", @"Hell", cursor])]);
    OCMExpect([textView setText:([NSString stringWithFormat:@"%@%@", @"Hello", cursor])]);
    
    /* Run */

    ConsoleViewController* viewController = [[ConsoleViewController alloc] initWithNibName:nil bundle:nil];
    viewController.textView = textView;
    [viewController view];
    
    [viewController print:msg andThen:nil];
    
    /* Verify */

    OCMVerifyAllWithDelay(textView, 15);
}

/**
 * Checks that completion handler is always called on main dispatch queue
 */
- (void) testPrintCompletionHandlerCalledOnMainQueue
{
    __block BOOL completionHandlerCalledOnMainThread = NO;
    
    /* Run */
    
    ConsoleViewController* viewController = [[ConsoleViewController alloc] initWithNibName:nil bundle:nil];
    [viewController view];
    
    [viewController print:@"Hello" andThen:^{
        completionHandlerCalledOnMainThread = [NSThread isMainThread];
    }];
    
    /* Verify */
    
    expect(completionHandlerCalledOnMainThread).after(15).to.beTruthy();
}

@end
