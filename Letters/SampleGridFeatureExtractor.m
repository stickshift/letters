//
//  SampleGridFeatureExtractor.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "SampleGridFeatureExtractor.h"
#import "UIImage+Letters.h"

// Constants
#define TAG @"SampleGridFeatureExtractor"

static BOOL containsPixelsInRect(NSData* pixelsInRGBA, CGRect rect, NSUInteger bytesPerPixel, NSUInteger bytesPerRow);

@implementation SampleGridFeatureExtractor

/**
 * Ctor
 */
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _resolution = 5;
    }
    return self;
}

- (NSArray*) extract:(UIImage*)image
{
    NSMutableArray* features = [NSMutableArray arrayWithCapacity:self.resolution*self.resolution];
    
    NSData* pixels = [image pixelsInRGBA8888];
    
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;

    // Use ceil to avoid under sampling
    NSUInteger blockWidth = ceil((double)width / self.resolution);
    NSUInteger blockHeight = ceil((double)height / self.resolution);
    
    NSLog(@"%@ - Extracting features from %lu x %lu image with blocks %lu x %lu", TAG, width, height, blockWidth, blockHeight);
    
    NSUInteger featureCount = 0;
    for (NSUInteger y = 0;y < height;y += blockHeight)
    {
        for (NSUInteger x = 0;x < width;x += blockWidth)
        {
            if (containsPixelsInRect(pixels, CGRectMake(x, y, blockWidth, blockHeight), 4, width * 4))
            {
                [features addObject:@1];
                featureCount++;
            }
            else
            {
                [features addObject:@0];
            }
        }
    }
    
    NSLog(@"%@ - Extracted %lu features: %@", TAG, featureCount, features);
    
    return features;
}

BOOL containsPixelsInRect(NSData* pixelsInRGBA, CGRect rect, NSUInteger bytesPerPixel, NSUInteger bytesPerRow)
{
    uint8_t* data = (uint8_t*)[pixelsInRGBA bytes];
    
    for (NSUInteger y = rect.origin.y;y < rect.origin.y + rect.size.height;y++)
    {
        for (NSUInteger x = rect.origin.x;x < rect.origin.x + rect.size.width;x++)
        {
            NSUInteger offset = y * bytesPerRow + x * bytesPerPixel;
            
            // If image dimensions are not evenly divisible by resolution, we may walk off the array
            // here. Make sure we bail first.
            if (offset >= pixelsInRGBA.length - 3)
            {
                return NO;
            }
            
            CGFloat alpha = (data[offset + 3] * 1.0) / 255.0;
            
            if (alpha > 0)
            {
                return YES;
            }
        }
    }
    
    return NO;
}

@end
