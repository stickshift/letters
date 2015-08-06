//
//  ChalkboardViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ChalkboardViewController.h"

// Constants
#define TAG @"ChalkboardViewController"

@interface ChalkboardViewController ()
{
    CGPoint _lastPoint;
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    CGFloat _brush;
}
@end

@implementation ChalkboardViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _red = 0.0/255.0;
    _green = 0.0/255.0;
    _blue = 0.0/255.0;
    _brush = 20.0;
}

/**
 * Starts tracking stroke
 */
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    _lastPoint = [[touches anyObject] locationInView:self.imageView];
}

/**
 * Tracks stroke and renders it on screen
 */
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.imageView];
    
    UIGraphicsBeginImageContext(self.imageView.frame.size);
    
    [self.imageView.image drawInRect:self.imageView.bounds];
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    _lastPoint = currentPoint;
}

/**
 * @see ChalkboardViewController.h
 */
- (IBAction) erase:(id)sender
{
    NSLog(@"%@ - Erasing chalkboard", TAG);
    
    self.imageView.image = nil;

    // Hide text view on erase
    self.textView.hidden = YES;
}

/**
 * @see ChalkboardViewController.h
 */
- (IBAction) submit:(id)sender
{
    NSLog(@"%@ - Submitting chalkboard", TAG);
}

@end
