//
//  ConsoleViewController.m
//  Letters
//
//  Created by Andrew Young on 8/4/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ConsoleViewController.h"

// Constants
#define TAG @"ConsoleViewController"
#define CURSOR @"\u200A\u258B"
#define DELAY_BETWEEN_CHARACTERS 0.07
#define DELAY_BETWEEN_LINES 1.0

@interface ConsoleViewController()

@property (strong, nonatomic, readonly) dispatch_queue_t animationQueue;
@property (strong, nonatomic, readonly) AVAudioPlayer* typingSound;
@property (strong, nonatomic) NSMutableString* buffer;

@end

@implementation ConsoleViewController

/**
 * @see ConsoleViewController.h
 */
+ (NSString*) cursor
{
    return CURSOR;
}

/**
 * Common initialization code
 */
- (void) initialize
{
    _animationQueue = dispatch_queue_create("Animation Queue", DISPATCH_QUEUE_SERIAL);
    
    NSURL* soundUrl = [[NSBundle mainBundle] URLForResource:@"typing" withExtension:@"wav"];
    _typingSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:NULL];
    _typingSound.numberOfLoops = -1;
    
    _buffer = [NSMutableString stringWithString:CURSOR];
}

/**
 * Ctor outside nib
 */
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initialize];
    }
    return self;
}

/**
 * Ctor inside nib
 */
- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize textView content
    self.textView.text = self.buffer;
}

/**
 * @see ConsoleViewController.h
 */
- (void) print:(NSString*)msg andThen:(void (^)())then
{
    if (!self.animationQueue)
    {
        return;
    }
    
    dispatch_async(self.animationQueue, ^{

        NSLog(@"%@ - Printing script", TAG);

        // Start with a dramatic delay
        [NSThread sleepForTimeInterval:DELAY_BETWEEN_LINES];

        [self.typingSound play];
        for (NSUInteger i = 0;i < msg.length;i++)
        {
            // Insert each character from line into buffer
            [self addCharacter:[msg characterAtIndex:i]];
            
            // Delay between characters
            [NSThread sleepForTimeInterval:DELAY_BETWEEN_CHARACTERS];
        }
        [self.typingSound stop];
        
        if (then)
        {
            // Always dispatch on main queue. Prevents clients from having to do this themselves.
            dispatch_async(dispatch_get_main_queue(), ^{ then(); });
        }
    });
}

/**
 * Adds a single character to content
 */
- (void) addCharacter:(unichar)c
{
    [self addString:[NSString stringWithCharacters:&c length:1]];
}

/**
 * Adds a whole string to content
 */
- (void) addString:(NSString*)s
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.buffer insertString:s atIndex:self.buffer.length - 2];
        
        self.textView.text = self.buffer;
    });
}

@end
