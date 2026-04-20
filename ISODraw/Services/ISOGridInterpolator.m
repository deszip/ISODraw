//
//  ISOGridInterpolator.m
//  ISODraw
//
//  Created by Deszip on 18/04/2026.
//

#import "ISOGridInterpolator.h"

@implementation ISOGridInterpolator

- (ISOGrid *)interpolateDataset:(ISODataset *)dataset rows:(NSInteger)rows columns:(NSInteger)columns {
    ISOGrid *grid = [[ISOGrid alloc] initWithRows:rows
                                          columns:columns
                                             minX:0.0
                                             minY:0.0
                                             maxX:1.0
                                             maxY:1.0];
    NSArray<ISODataPoint *> *samplePoints = dataset.allPoints;

    for (NSInteger row = 0; row < grid.rows; row++) {
        for (NSInteger column = 0; column < grid.columns; column++) {
            NSPoint gridPoint = [grid pointAtRow:row column:column];
            double value = [self interpolatedValueForPoint:gridPoint fromSamples:samplePoints];
            [grid setValue:value row:row column:column];            
        }
    }

    return grid;
}

- (double)interpolatedValueForPoint:(NSPoint)point fromSamples:(NSArray<ISODataPoint *> *)samplePoints {
    double weightedValueSum = 0.0;
    double totalWeight = 0.0;

    for (ISODataPoint *samplePoint in samplePoints) {
        double distance = hypot(point.x - samplePoint.x, point.y - samplePoint.y);
        double weight = 1.0 / (distance * distance);
        weightedValueSum += samplePoint.value * weight;
        totalWeight += weight;
    }

    return totalWeight > 0.0 ? weightedValueSum / totalWeight : 0.0;
}

@end
