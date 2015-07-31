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
- (void) testPlayScript
{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    __block BOOL scriptCompleted = NO;
    
    // Create a simple script
    Script* script = [[Script alloc] init];
    [script addLine:@"HELLO"];
    [script addLine:@"WOULD YOU BE MY FRIEND?"];
    
    // Initialize the view controller
    ConsoleViewController* consoleViewController = [storyBoard instantiateInitialViewController];
    [consoleViewController view];
    
    // Play the script
    consoleViewController.script = script;
    [consoleViewController playAndThen:^{
        scriptCompleted = YES;
    }];
    
    // Verify script completed
    expect(scriptCompleted).after(30).to.beTruthy();
}

@end
