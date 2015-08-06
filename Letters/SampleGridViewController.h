//
//  SampleGridViewController.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleGridFeatureExtractor.h"

/**
 * Visualizes the sample grid of a SampleGridFeatureExtractor
 */
@interface SampleGridViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView* imageView;

@property (strong, nonatomic) SampleGridFeatureExtractor* featureExtractor;

@end
