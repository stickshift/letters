//
//  ConsoleViewController.m
//  Letters
//
//  Created by Andrew Young on 7/29/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ConsoleViewController.h"

// Constants
#define TAG @"ConsoleViewController"

@implementation ConsoleViewController

- (void) playScript:(Script*)script onCompletion:(void (^)(void))finished
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@ - Playing script", TAG);
        
        if (finished) finished();
        
    });
}

@end
