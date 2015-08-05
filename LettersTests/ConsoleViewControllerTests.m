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
- (void) testPrint
{
    NSString* msg = @"Hello World";
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    __block BOOL completionHandlerCalled = NO;
    
    /* Run */

    ConsoleViewController* viewController = [[ConsoleViewController alloc] initWithNibName:nil bundle:nil];
    viewController.textView = textView;
    [viewController print:msg andThen:^{
        completionHandlerCalled = YES;
    }];
    
    /* Verify */
    
    expect(textView.text).after(30).to.equal([NSString stringWithFormat:@"%@%@", msg, [ConsoleViewController cursor]]);
    expect(completionHandlerCalled).after(30).to.beTruthy();
}

@end
