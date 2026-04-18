//
//  ISOPointGenerator.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISOPointGenerator.h"

#import "ISODataPoint.h"

@implementation ISOPointGenerator

- (ISODataset *)generateDatasetWithPointCount:(NSUInteger)pointCount {
    NSUInteger totalPointCount = MAX(pointCount, 24);
    double centerX = [self randomDoubleInRangeFrom:0.20 to:0.80];
    double centerY = [self randomDoubleInRangeFrom:0.20 to:0.80];
    ISODataPoint *centerPoint = [[ISODataPoint alloc] initWithX:centerX y:centerY value:100.0];

    NSArray<NSValue *> *corners = @[
        [NSValue valueWithPoint:NSMakePoint(0.0, 0.0)],
        [NSValue valueWithPoint:NSMakePoint(1.0, 0.0)],
        [NSValue valueWithPoint:NSMakePoint(0.0, 1.0)],
        [NSValue valueWithPoint:NSMakePoint(1.0, 1.0)]
    ];

    double maxDistance = 0.0;
    for (NSValue *cornerValue in corners) {
        NSPoint corner = cornerValue.pointValue;
        double distance = hypot(corner.x - centerX, corner.y - centerY);
        maxDistance = MAX(maxDistance, distance);
    }

    NSMutableArray<ISODataPoint *> *samplePoints = [NSMutableArray arrayWithCapacity:totalPointCount - 1];
    for (NSUInteger index = 0; index < totalPointCount - 1; index++) {
        double x = [self randomDoubleInRangeFrom:0.0 to:1.0];
        double y = [self randomDoubleInRangeFrom:0.0 to:1.0];
        double distance = hypot(x - centerX, y - centerY);
        double normalizedDistance = maxDistance > 0.0 ? distance / maxDistance : 0.0;
        double value = MAX(0.0, 100.0 * (1.0 - normalizedDistance));
        [samplePoints addObject:[[ISODataPoint alloc] initWithX:x y:y value:value]];
    }

    NSDate *createdAt = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterNoStyle;
    formatter.timeStyle = NSDateFormatterMediumStyle;
    NSString *name = [NSString stringWithFormat:@"Set %@", [formatter stringFromDate:createdAt]];

    return [[ISODataset alloc] initWithIdentifier:NSUUID.UUID.UUIDString
                                             name:name
                                        createdAt:createdAt
                                      centerPoint:centerPoint
                                     samplePoints:samplePoints];
}

- (double)randomDoubleInRangeFrom:(double)minValue to:(double)maxValue {
    double fraction = (double)arc4random() / (double)UINT32_MAX;
    return minValue + (maxValue - minValue) * fraction;
}

@end
