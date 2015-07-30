//
//  ScriptTests.m
//  Letters
//
//  Created by Andrew Young on 7/30/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import <Expecta/Expecta.h>
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Script.h"

@interface ScriptTests : XCTestCase @end
@implementation ScriptTests

- (void)testLines
{
    NSString* line1 = @"line1";
    NSString* line2 = @"line2";
    NSString* line3 = @"line3";

    // Add 3 lines    
    Script* script = [[Script alloc] init];
    [script addLine:line1];
    [script addLine:line2];
    [script addLine:line3];
    
    // Step through each line
    expect([script nextLine]).to.equal(line1);
    expect([script nextLine]).to.equal(line2);
    expect([script nextLine]).to.equal(line3);
    expect([script nextLine]).to.beNil();
    
    // Reset
    [script reset];
    
    // Step through each line again
    expect([script nextLine]).to.equal(line1);
    expect([script nextLine]).to.equal(line2);
    expect([script nextLine]).to.equal(line3);
    expect([script nextLine]).to.beNil();
}

- (void) setUp
{
    [super setUp];
    
    self.continueAfterFailure = NO;
}

@end
