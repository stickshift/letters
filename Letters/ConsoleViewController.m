//
//  ConsoleViewController.m
//  Letters
//
//  Created by Andrew Young on 7/29/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ConsoleViewController.h"

// Constants
#define TAG @"ConsoleViewController"
#define BLOCK @"\u200A\u258B"
#define DELAY_BETWEEN_CHARACTERS 0.07
#define DELAY_BETWEEN_LINES 1.0

@interface ConsoleViewController()

@property dispatch_queue_t playingQueue;
@property NSMutableString* buffer;
@property AVAudioPlayer* typingSound;

@property (weak, nonatomic) IBOutlet UITextView* textView;
@property CGFloat lineHeight;

@end

@implementation ConsoleViewController

- (instancetype) initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (self)
    {
        self.playingQueue = dispatch_queue_create("playingQueue", DISPATCH_QUEUE_SERIAL);
        self.buffer = [NSMutableString stringWithString:BLOCK];
        
        NSURL* soundUrl = [[NSBundle mainBundle] URLForResource:@"typing" withExtension:@"wav"];
        self.typingSound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:NULL];
        self.typingSound.numberOfLoops = -1;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    // Calculate lineHeight
    NSDictionary* attributes = @{ NSFontAttributeName: self.textView.font };
    CGRect bounds = [@"H" boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:attributes
                                       context:nil];
    self.lineHeight = ceil(bounds.size.height);

    // Initialize the textView
    self.textView.text = self.buffer;
    
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
                [self addString:@"\n"];
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

    [self.typingSound play];
    for (NSUInteger i = 0;i < line.length;i++)
    {
        // Insert each character from line into buffer
        [self addCharacter:[line characterAtIndex:i]];

        // Delay between characters
        [NSThread sleepForTimeInterval:DELAY_BETWEEN_CHARACTERS];
    }
    [self.typingSound stop];

    // Delay between lines
    [NSThread sleepForTimeInterval:DELAY_BETWEEN_LINES];
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
        
        if ([self viewWillOverflow])
        {
            NSLog(@"%@ - Resetting console", TAG);
            self.buffer = [NSMutableString stringWithFormat:@"%@%@", s, BLOCK];
            self.textView.text = self.buffer;
        }
    });
}

/**
 * Utility that decides if UITextView is full
 */
- (BOOL) viewWillOverflow
{
    if (self.textView.frame.size.height - self.textView.contentSize.height < self.lineHeight)
    {
        return YES;
    }
    
    return NO;
}

@end
