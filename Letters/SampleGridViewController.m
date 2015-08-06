//
//  SampleGridViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "SampleGridViewController.h"

@interface SampleGridViewController ()
{
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    CGFloat _brush;
}
@end

@implementation SampleGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _red = 0.0/255.0;
    _green = 0.0/255.0;
    _blue = 0.0/255.0;
    _brush = 2.0;
    
    [self renderSampleGrid];
}

- (void) renderSampleGrid
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize blockSize = [self.featureExtractor blockSizeOfImage:imageSize];
    
    UIGraphicsBeginImageContext(imageSize);

    // Set drawing attributes
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);

    [self.imageView.image drawInRect:self.imageView.bounds];
    
    // Draw columns
    for (CGFloat x = 0;x <= imageSize.width;x += blockSize.width)
    {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, 0);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x, imageSize.height);
    }
    
    // Draw rows
    for (CGFloat y = 0;y <= imageSize.height;y += blockSize.height)
    {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 0, y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), imageSize.width, y);
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

@end
