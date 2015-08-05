//
//  UIImage+Letters.h
//  Letters
//
//  Created by Andrew Young on 8/5/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Letters)

/**
 * Returns memory buffer with image data converted to 8-bit RGBA format.
 */
- (NSData*) pixelsInRGBA8888;

@end
