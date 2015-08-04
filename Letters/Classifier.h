//
//  Classifier.h
//  Letters
//
//  Created by Andrew Young on 8/3/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Specifies interface for a simple supervised learning algorithm.
 */
@interface Classifier : NSObject

/**
 * Trains classifier that this pattern should generate this output.
 */
- (void) trainInput:(NSArray*)input generatesOutput:(NSUInteger)output;

@end
