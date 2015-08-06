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

/**
 * @see SampleGridFeatureExtractor.h
 */
- (CGSize) blockSizeOfImage:(CGSize)imageSize
{
    return CGSizeMake(imageSize.width / self.resolution, imageSize.height / self.resolution);
}

- (NSArray*) extract:(UIImage*)image
{
    NSMutableArray* features = [NSMutableArray arrayWithCapacity:self.resolution*self.resolution];
    
    NSData* pixels = [image pixelsInRGBA8888];

    // Use ceil to avoid under sampling
    CGSize imageSize = image.size;
    CGSize blockSize = [self blockSizeOfImage:imageSize];
    
    NSLog(@"%@ - Extracting features from %f x %f image with blocks %f x %f", TAG, imageSize.width, imageSize.height, blockSize.width, blockSize.height);
    
    NSUInteger featureCount = 0;
    for (CGFloat y = 0;y < imageSize.height;y += blockSize.height)
    {
        for (CGFloat x = 0;x < imageSize.width;x += blockSize.width)
        {
            if (containsPixelsInRect(pixels, CGRectMake(x, y, blockSize.width, blockSize.height), 4, imageSize.width * 4))
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
    
    for (CGFloat y = rect.origin.y;y < rect.origin.y + rect.size.height;y++)
    {
        for (CGFloat x = rect.origin.x;x < rect.origin.x + rect.size.width;x++)
        {
            NSUInteger offset = round(y) * bytesPerRow + round(x) * bytesPerPixel;
            
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
