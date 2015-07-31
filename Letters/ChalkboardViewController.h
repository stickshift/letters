//
//  ChalkboardViewController.h
//  Letters
//
//  Created by Andrew Young on 7/31/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChalkboardViewController : UIViewController

/**
 * Clears chalkboard
 */
- (IBAction) erase:(id)sender;

/**
 * Call when user is happy with drawing and ready to submit it
 */
- (IBAction) submit:(id)sender;

@end
