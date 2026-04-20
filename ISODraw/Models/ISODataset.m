//
//  ISODataset.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISODataset.h"

@implementation ISODataset

- (instancetype)initWithIdentifier:(NSString *)identifier
                       centerPoint:(ISODataPoint *)centerPoint
                      samplePoints:(NSArray<ISODataPoint *> *)samplePoints {
    self = [super init];
    if (self) {
        _identifier = [identifier copy];
        _centerPoint = centerPoint;
        _samplePoints = [samplePoints copy];
    }
    return self;
}

- (NSArray<ISODataPoint *> *)allPoints {
    NSMutableArray<ISODataPoint *> *points = [self.samplePoints mutableCopy];
    [points addObject:self.centerPoint];
    return [points copy];
}

@end
