//
//  ChalkboardViewController.m
//  Letters
//
//  Created by Andrew Young on 7/31/15.
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

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    _red = 0.0/255.0;
    _green = 128.0/255.0;
    _blue = 255.0/255.0;
    _brush = 20.0;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self erase:self];
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

/**
 * Records start of stroke
 */
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _lastPoint = [[touches anyObject] locationInView:self.view];
}

/**
 * Renders stroke on screen
 */
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
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

@end
