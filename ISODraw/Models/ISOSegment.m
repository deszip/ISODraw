//
//  ISOSegment.m
//  ISODraw
//
//  Created by Deszip on 18/04/2026.
//

#import "ISOSegment.h"

@implementation ISOSegment

- (instancetype)initWithThreshold:(double)threshold start:(NSPoint)start end:(NSPoint)end {
    self = [super init];
    if (self) {
        _threshold = threshold;
        _start = start;
        _end = end;
    }
    return self;
}

@end
