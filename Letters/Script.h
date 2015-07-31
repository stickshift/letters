//
//  Script.h
//  Letters
//
//  Created by Andrew Young on 7/30/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Script : NSObject

/**
 * Adds a new line to the end of the script.
 */
- (void) addLine:(NSString*)line;

/**
 * Returns TRUE if the line is a special confirmation request token
 */
+ (BOOL) isConfirmationRequest:(NSString*)line;

/**
 * Adds a special token to script where play pauses waiting for confirmation
 */
- (void) addConfirmationRequest;

/**
 * Returns the next line in the script or nil if there are none left.
 */
- (NSString*) nextLine;

/**
 * Resets current line to the beginning.
 */
- (void) reset;

@end
