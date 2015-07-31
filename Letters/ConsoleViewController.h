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

@property (nonatomic) Script* script;

/**
 * Starts playing a script on the Console
 */
- (void) playAndThen:(void (^)(void))finished;

@end

