//
//  ConsoleViewControllerTests.m
//  Letters
//
//  Created by Andrew Young on 7/30/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LettersTestCase.h"
#import "ConsoleViewController.h"
#import "Script.h"

@interface ConsoleViewControllerTests : LettersTestCase @end
@implementation ConsoleViewControllerTests

/**
 * Tests the basics of playing a script.
 */
- (void) testPlay
{
    __block BOOL finished;
    
    // Create a simple script
    Script* script = [[Script alloc] init];
    [script addLine:@"HELLO"];
    [script addLine:@"WOULD YOU BE MY FRIEND?"];
    
    // Initialize the view controller
    ConsoleViewController* consoleViewController = [[ConsoleViewController alloc] initWithNibName:@"ConsoleView"
                                                                                           bundle:[NSBundle mainBundle]];
    [consoleViewController view];
    
    // Play the script
    [consoleViewController play:script andThen:^{
        finished = YES;
    }];
    
    // Verify viewController finished
    expect(finished).after(30).to.beTruthy();
}

@end