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

/** The script to play */
@property (nonatomic) Script* script;

/** TRUE if play is paused waiting for confirm to be called */
@property (nonatomic, readonly) BOOL waitingForConfirmation;

/** TRUE if the end of the script was reached */
@property (nonatomic, readonly) BOOL finished;

/**
 * Starts playing a script on the Console
 */
- (void) play;

/**
 * Confirms a question and lets play proceed.
 */
- (IBAction) confirm:(id)sender;

@end

