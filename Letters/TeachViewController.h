//
//  TeachViewController.h
//  Letters
//
//  Created by Andrew Young on 7/31/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "ChalkboardViewController.h"
#import "PatternParser.h"
#import "Classifier.h"

@interface TeachViewController : ChalkboardViewController

@property (nonatomic) NSArray* dictionary;
@property (nonatomic) NSUInteger currentLetter;
@property PatternParser* patternParser;
@property Classifier* classifier;

@end
