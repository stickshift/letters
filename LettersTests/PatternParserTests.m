//
//  PatternParserTests.m
//  Letters
//
//  Created by Andrew Young on 8/3/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "LettersTestCase.h"
#import "PatternParser.h"

@interface PatternParserTests : LettersTestCase @end
@implementation PatternParserTests

/**
 * Parses an image thats covered in solid ink and verifies the pattern returned is all 1s.
 */
- (void) testParseAllOnes
{
    UIImage* image = nil;
    
    /* Setup */
    
    // Create a UIImage that's completely filled in
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor blackColor] setFill];
    [path fill];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    /* Execute */

    PatternParser* parser = [[PatternParser alloc] init];
    NSArray* pattern = [parser parse:image];
    
    /* Verify */
    
    // Check pattern size
    expect(pattern.count).to.equal(parser.resolution * parser.resolution);
    
    // Verify pattern is all 1s
    for (NSNumber* p in pattern)
    {
        expect([p unsignedIntegerValue]).to.equal(1);
    }
}

/**
 * Parses an image thats empty and verifies the pattern returned is all 0s.
 */
- (void) testParseAllZeros
{
    UIImage* image = nil;
    
    /* Setup */
    
    // Create a UIImage that's completely empty
    UIGraphicsBeginImageContext(CGSizeMake(100, 100));
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    /* Execute */
    
    PatternParser* parser = [[PatternParser alloc] init];
    NSArray* pattern = [parser parse:image];

    /* Verify */
    
    // Check pattern size
    expect(pattern.count).to.equal(parser.resolution * parser.resolution);
    
    // Verify pattern is all 0s
    for (NSNumber* p in pattern)
    {
        expect([p unsignedIntegerValue]).to.equal(0);
    }
}

/**
 * Parses an image colored in with alternating squares and verify the pattern alternates between 1
 * and 0
 */
- (void) testParseCheckerboard
{
    UIImage* image = nil;
    NSUInteger width = 100;
    NSUInteger height = 100;
    NSUInteger resolution = 5;
    NSUInteger blockWidth = width / resolution;
    NSUInteger blockHeight = height / resolution;
    
    /* Setup */
    
    // Create a UIImage that's filled in every other block
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [[UIColor blackColor] setFill];
    
    for (NSUInteger y = 0;y < height;y += blockHeight)
    {
        for (NSUInteger x = 0;x < width;x += blockWidth)
        {
            // Fill every other block and swap starting block on each row
            if ((x / blockWidth) % 2 == ((y / blockHeight) % 2))
            {
                UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(x, y, blockWidth, blockHeight)];
                [path fill];
            }            
        }
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    /* Execute */
    
    PatternParser* parser = [[PatternParser alloc] init];
    NSArray* pattern = [parser parse:image];
    
    /* Verify */
    
    // Check pattern size
    expect(pattern.count).to.equal(parser.resolution * parser.resolution);
    
    // Verify pattern alternates between 1 and 0
    for (NSUInteger i = 0;i < parser.resolution * parser.resolution;i++)
    {
        if (i % 2)
        {
            expect([pattern[i] unsignedIntegerValue]).to.equal(0);
        }
        else
        {
            expect([pattern[i] unsignedIntegerValue]).to.equal(1);
        }
    }
}

@end
