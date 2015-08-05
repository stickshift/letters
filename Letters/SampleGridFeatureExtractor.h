//
//  SampleGridFeatureExtractor.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeatureExtractor.h"

@interface SampleGridFeatureExtractor : NSObject<FeatureExtractor>

/** Sets the size of the sampling grid to resolution x resolution. Default is 5. */
@property (nonatomic) NSUInteger resolution;

/**
 * @see FeatureExtractor.h
 */
- (NSArray*) extract:(UIImage*)image;

@end
