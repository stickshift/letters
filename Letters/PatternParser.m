//
//  PatternParser.m
//  Letters
//
//  Created by Andrew Young on 8/3/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "PatternParser.h"
#import "UIImage+Letters.h"

static BOOL containsPixelsInRect(NSData* pixelsInRGBA, CGRect rect, NSUInteger bytesPerPixel, NSUInteger bytesPerRow);

@implementation PatternParser

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
 * @see PatternParser.h
 */
- (NSArray*) parse:(UIImage*)image
{
    NSMutableArray* pattern = [NSMutableArray arrayWithCapacity:self.resolution*self.resolution];
    
    NSUInteger width = image.size.width;
    NSUInteger blockWidth = width / self.resolution;
    NSUInteger height = image.size.height;
    NSUInteger blockHeight = height / self.resolution;
    NSData* pixels = [image pixelsInRGBA8888];
    
    for (NSUInteger y = 0;y < height;y += blockHeight)
    {
        for (NSUInteger x = 0;x < width;x += blockWidth)
        {
            if (containsPixelsInRect(pixels, CGRectMake(x, y, blockWidth, blockHeight), 4, width * 4))
            {
                [pattern addObject:@1];
            }
            else
            {
                [pattern addObject:@0];
            }
        }
    }

    return pattern;
}

@end

BOOL containsPixelsInRect(NSData* pixelsInRGBA, CGRect rect, NSUInteger bytesPerPixel, NSUInteger bytesPerRow)
{
    uint8_t* data = (uint8_t*)[pixelsInRGBA bytes];
    
    for (NSUInteger y = rect.origin.y;y < rect.origin.y + rect.size.height;y++)
    {
        for (NSUInteger x = rect.origin.x;x < rect.origin.x + rect.size.width;x++)
        {
            NSUInteger offset = y * bytesPerRow + x * bytesPerPixel;
//            CGFloat red   = (data[offset]     * 1.0) / 255.0;
//            CGFloat green = (data[offset + 1] * 1.0) / 255.0;
//            CGFloat blue  = (data[offset + 2] * 1.0) / 255.0;
            CGFloat alpha = (data[offset + 3] * 1.0) / 255.0;
            
            if (alpha > 0)
            {
                return YES;
            }
        }
    }
    
    return NO;
}

