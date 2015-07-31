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
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    // Create a simple script
    Script* script = [[Script alloc] init];
    [script addLine:@"HELLO"];
    [script addLine:@"WOULD YOU BE MY FRIEND?"];
    
    // Initialize the view controller
    ConsoleViewController* consoleViewController = [storyBoard instantiateInitialViewController];
    [consoleViewController view];
    
    // Play the script
    consoleViewController.script = script;
    [consoleViewController play];
    
    // Verify viewController finished
    expect(consoleViewController.finished).after(30).to.beTruthy();
}

/**
 * Tests the basics of playing a script.
 */
- (void) testInteractivePlay
{
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    // Create a simple script
    Script* script = [[Script alloc] init];
    [script addLine:@"HELLO"];
    [script addLine:@"WOULD YOU BE MY FRIEND?"];
    [script addConfirmationRequest];
    [script addLine:@"THANKS!"];

    // Initialize the view controller
    ConsoleViewController* consoleViewController = [storyBoard instantiateInitialViewController];
    [consoleViewController view];
    
    // Play the script
    consoleViewController.script = script;
    [consoleViewController play];
    
    // Verify viewController is waiting for input
    expect(consoleViewController.waitingForConfirmation).after(30).to.beTruthy();
    expect(consoleViewController.finished).after(30).to.beFalsy();
    
    // Confirm and let the play continue
    [consoleViewController confirm:self];
    
    // Verify viewController finished
    expect(consoleViewController.waitingForConfirmation).after(30).to.beFalsy();
    expect(consoleViewController.finished).after(30).to.beTruthy();
}

@end
