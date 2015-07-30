//
//  Script.m
//  Letters
//
//  Created by Andrew Young on 7/30/15.
//  Copyright (c) 2015 Andrew Young. All rights reserved.
//

#import "Script.h"

@interface Script()
{
    NSMutableArray* _lines;
    NSUInteger _currentLine;
}
@end

@implementation Script

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _lines = [NSMutableArray array];
    }
    return self;
}

- (void) addLine:(NSString*)line
{
    [_lines addObject:line];
}

- (NSString*) nextLine
{
    if (_currentLine >= _lines.count)
    {
        return nil;
    }
    
    return _lines[_currentLine++];
}

- (void) reset
{
    _currentLine = 0;
}

@end
