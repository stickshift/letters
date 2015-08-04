//
//  PatternParser.h
//  Letters
//
//  Created by Andrew Young on 8/3/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * Parses the pattern in a UIImage into an array of 1s and 0s using a sampling grid.
 */
@interface PatternParser : NSObject

/** Sets the size of the sampling grid to resolution x resolution. Default is 5. */
@property (nonatomic) NSUInteger resolution;

/** Applies sampling grid to parse image into an array of 1s and 0s. */
- (NSArray*) parse:(UIImage*)image;

@end
