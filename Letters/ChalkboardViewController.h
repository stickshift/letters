//
//  ChalkboardViewController.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ConsoleViewController.h"

/**
 * Base class for views that support hand drawing including erasing and submitting.
 */
@interface ChalkboardViewController : ConsoleViewController

/** The image view used to render finger strokes */
@property (weak, nonatomic) IBOutlet UIImageView* imageView;

/** 
 * Clears the image 
 */
- (IBAction) erase:(id)sender;

/** 
 * Submits the image for processing. Call this when the user is "done" with the drawing. 
 */
- (IBAction) submit:(id)sender;

@end
