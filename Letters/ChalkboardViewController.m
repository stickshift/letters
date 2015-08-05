//
//  ChalkboardViewController.m
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ChalkboardViewController.h"

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

/**
 * Ctor
 */
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _red = 0.0/255.0;
        _green = 0.0/255.0;
        _blue = 0.0/255.0;
        _brush = 20.0;
    }
    return self;
}

/**
 * Starts tracking stroke
 */
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    _lastPoint = [[touches anyObject] locationInView:self.view];
}

/**
 * Tracks stroke and renders it on screen
 */
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self.view];

    UIGraphicsBeginImageContext(self.view.frame.size);
    
    [self.imageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
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
    self.imageView.image = nil;
}

/**
 * @see ChalkboardViewController.h
 */
- (IBAction) submit:(id)sender
{
    
}

@end
