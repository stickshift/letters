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
#define BLOCK @"\u258B"
#define DELAY_BETWEEN_CHARACTERS 0.1
#define DELAY_BETWEEN_LINES 0.8

@interface ConsoleViewController()

@property dispatch_queue_t playingQueue;
@property NSMutableString* buffer;

@property (weak, nonatomic) IBOutlet UITextView* textView;

@end

@implementation ConsoleViewController

- (instancetype) initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (self)
    {
        self.playingQueue = dispatch_queue_create("playingQueue", DISPATCH_QUEUE_SERIAL);
        self.buffer = [NSMutableString stringWithString:BLOCK];
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize the textView
    [self updateView];
    
    // Play a script if we have one
    if (self.script)
    {
        [self playAndThen:nil];
    }
}

/**
 * @see ConsoleViewController.h
 */
- (void) playAndThen:(void (^)(void))finished
{
    dispatch_async(self.playingQueue, ^{
        
        NSLog(@"%@ - Playing script", TAG);
        
        // Start with a dramatic delay
        [NSThread sleepForTimeInterval:DELAY_BETWEEN_LINES];
        
        NSString* line = [self.script nextLine];
        while (line)
        {
            [self playLine:line];
            line = [self.script nextLine];
            
            // Insert newline here so the last line doesn't get one
            if (line)
            {
                [self.buffer insertString:@"\n" atIndex:self.buffer.length - 1];
                
                // Update the textView
                [self updateView];
            }
        }
        
        if (finished) finished();
        
    });
}

/**
 * Animates a single line one character at a time
 */
- (void) playLine:(NSString*)line
{
    NSLog(@"%@ - Playing line '%@'", TAG, line);

    for (NSUInteger i = 0;i < line.length;i++)
    {
        // Insert each character from line into buffer
        unichar c = [line characterAtIndex:i];
        [self.buffer insertString:[NSString stringWithCharacters:&c length:1]
                          atIndex:self.buffer.length - 1];
        
        // Update the textView
        [self updateView];

        // Delay between characters
        [NSThread sleepForTimeInterval:DELAY_BETWEEN_CHARACTERS];
    }

    // Delay between lines
    [NSThread sleepForTimeInterval:DELAY_BETWEEN_LINES];
}

/**
 * Updates textView on main thread
 */
- (void) updateView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = self.buffer;
    });
}

@end
