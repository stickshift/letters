//
//  ConsoleViewController.h
//  Letters
//
//  Created by Andrew Young on 7/29/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Script.h"

@interface ConsoleViewController : UIViewController

/** TRUE if play is paused waiting for confirm to be called */
@property (nonatomic, readonly) BOOL waitingForConfirmation;

/**
 * Starts playing a script on the Console
 */
- (void) play:(Script*)script andThen:(void (^)())finished;

/**
 * Confirms a question and lets play proceed.
 */
- (IBAction) confirm:(id)sender;

/**
 * Resets console to empty
 */
- (void) clear;

@end
