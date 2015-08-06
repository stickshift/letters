//
//  FeatureExtractor.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * A protocol that defines interface for feature extraction algorithms.
 */
@protocol FeatureExtractor <NSObject>

/**
 * Extracts features from an image.
 */
- (NSArray*) extract:(UIImage*)image;

@end
