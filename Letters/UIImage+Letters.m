//
//  UIImage+Letters.m
//  Letters
//
//  Created by Andrew Young on 8/3/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "UIImage+Letters.h"

@implementation UIImage(Letters)

- (NSData*) pixelsInRGBA8888;
{
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;

    uint8_t* data = (uint8_t*)calloc(width * height * bytesPerPixel, sizeof(uint8_t));

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(data,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);

    CGContextRelease(context);

    return [NSData dataWithBytesNoCopy:data length:(width * height * bytesPerPixel * sizeof(uint8_t)) freeWhenDone:YES];
}

@end
