//
//  TeachViewController.m
//  Letters
//
//  Created by Andrew Young on 7/31/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "TeachViewController.h"

@interface TeachViewController()

@property (nonatomic) NSMutableArray* sampleCounts;

@property (weak, nonatomic) IBOutlet UISegmentedControl* modeSelector;
@property (weak, nonatomic) IBOutlet UILabel* letterLabel;
@property (weak, nonatomic) IBOutlet UILabel* samplesLabel;

@end

@implementation TeachViewController

- (id) initWithCoder:(NSCoder*)decoder
{
    self = [super initWithCoder:decoder];
    if (self)
    {
        self.dictionary = @[ @"A", @"B", @"C" ];
        self.sampleCounts = [NSMutableArray arrayWithObjects:@0, @0, @0, nil];
        self.currentLetter = 0;
    }
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.letterLabel.text = self.dictionary[self.currentLetter];
    self.samplesLabel.text = [NSString stringWithFormat:@"%@", self.sampleCounts[self.currentLetter]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.modeSelector.selectedSegmentIndex = 0;
}

/**
 * @see ChalkboardViewController.h
 */
- (IBAction) submit:(id)sender
{
    // Parse image into a pattern
    NSArray* pattern = [self.patternParser parse:self.imageView.image];

    // Train the classifier
    [self.classifier trainInput:pattern generatesOutput:self.currentLetter];
    
    // Move on with life
    [self askForNextLetter];
}

- (IBAction) toggleModes:(id)sender
{
    self.tabBarController.selectedIndex = self.modeSelector.selectedSegmentIndex;
}

- (void) askForNextLetter
{
    // Bump sample count
    NSUInteger count = [self.sampleCounts[self.currentLetter] unsignedIntegerValue] + 1;
    self.sampleCounts[self.currentLetter] = @(count);
    
    // Bump current letter
    self.currentLetter++;
    if (self.currentLetter == self.dictionary.count)
    {
        self.currentLetter = 0;
    }
    
    // Clear board
    [self erase:self];
    
    // Update labels
    self.letterLabel.text = self.dictionary[self.currentLetter];
    self.samplesLabel.text = [NSString stringWithFormat:@"%@", self.sampleCounts[self.currentLetter]];
}

@end
