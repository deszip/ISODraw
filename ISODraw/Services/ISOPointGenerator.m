//
//  ISOPointGenerator.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISOPointGenerator.h"

#import "ISODataPoint.h"

@implementation ISOPointGenerator

- (instancetype)init {
    self = [super init];
    if (self) {
        _useDeviation = YES;
    }
    
    return self;
}

- (ISODataset *)generateDatasetWithPointCount:(NSUInteger)pointCount {
    // Get a center somewhere in the corner, in 20 to 80 percents of area
    double centerX = [self randomDoubleInRangeFrom:0.20 to:0.80];
    double centerY = [self randomDoubleInRangeFrom:0.20 to:0.80];
    ISODataPoint *centerPoint = [[ISODataPoint alloc] initWithX:centerX y:centerY value:100.0];

    // Get a distance from our center to farest corner
    NSArray<NSValue *> *corners = @[
        [NSValue valueWithPoint:NSMakePoint(0.0, 0.0)],
        [NSValue valueWithPoint:NSMakePoint(1.0, 0.0)],
        [NSValue valueWithPoint:NSMakePoint(0.0, 1.0)],
        [NSValue valueWithPoint:NSMakePoint(1.0, 1.0)]
    ];

    // Get a farest corner
    double maxDistance = 0.0;
    for (NSValue *cornerValue in corners) {
        NSPoint corner = cornerValue.pointValue;
        double distance = hypot(corner.x - centerX, corner.y - centerY);
        maxDistance = MAX(maxDistance, distance);
    }
    
    // Build points
    NSMutableArray<ISODataPoint *> *samplePoints = [NSMutableArray arrayWithCapacity:pointCount - 1];
    for (NSUInteger index = 0; index < pointCount - 1; index++) {
        double x = [self randomDoubleInRangeFrom:0.0 to:1.0];
        double y = [self randomDoubleInRangeFrom:0.0 to:1.0];
        double distance = hypot(x - centerX, y - centerY);
        double normalizedDistance = maxDistance > 0.0 ? distance / maxDistance : 0.0;
        double baseValue = MAX(0.0, 100.0 * (1.0 - normalizedDistance));
        double value = baseValue;
        
        // Add a deviation of 5 points
        if (self.useDeviation == YES) {
            double deviation = [self randomDoubleInRangeFrom:-5.0 to:5.0];;
            value = MIN(100.0, MAX(0.0, baseValue + deviation));
        }
        
        [samplePoints addObject:[[ISODataPoint alloc] initWithX:x y:y value:value]];
    }

    NSLog(@"Points: %@", samplePoints);
    
    return [[ISODataset alloc] initWithIdentifier:NSUUID.UUID.UUIDString
                                      centerPoint:centerPoint
                                     samplePoints:samplePoints];
}

- (double)randomDoubleInRangeFrom:(double)minValue to:(double)maxValue {
    double fraction = (double)arc4random() / (double)UINT32_MAX;
    return minValue + (maxValue - minValue) * fraction;
}

@end
