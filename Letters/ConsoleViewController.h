//
//  ConsoleViewController.h
//  Letters
//
//  Created by Andrew Young on 8/4/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Provides base class for view controllers that print output to the "console"
 */
@interface ConsoleViewController : UIViewController

/** The text view where content is printed */
@property (weak, nonatomic) IBOutlet UITextView* textView;

/**
 * Returns the special token used to delimit the console cursor
 */
+ (NSString*) cursor;

/**
 * Animates msg being printed on console and calls completion block when animation is finished.
 */
- (void) print:(NSString*)msg andThen:(void (^)())then;

@end
