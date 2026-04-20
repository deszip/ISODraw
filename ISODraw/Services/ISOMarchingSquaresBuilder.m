//
//  ISOMarchingSquaresBuilder.m
//  ISODraw
//
//  Created by Deszip on 19/04/2026.
//

#import "ISOMarchingSquaresBuilder.h"

@implementation ISOMarchingSquaresBuilder

- (NSArray<ISOSegment *> *)buildSegmentsForGrid:(ISOGrid *)grid thresholds:(NSArray<NSNumber *> *)thresholds {
    NSMutableArray<ISOSegment *> *segments = [NSMutableArray array];
    for (NSNumber *thresholdNumber in thresholds) {
        [segments addObjectsFromArray:[self segmentsForGrid:grid threshold:thresholdNumber.doubleValue]];
    }
    return [segments copy];
}

- (NSArray<ISOSegment *> *)segmentsForGrid:(ISOGrid *)grid threshold:(double)threshold {
    NSMutableArray<ISOSegment *> *segments = [NSMutableArray array];

    for (NSInteger row = 0; row < grid.rows - 1; row++) {
        for (NSInteger column = 0; column < grid.columns - 1; column++) {
            double d00 = [grid valueAtRow:row column:column];
            double d10 = [grid valueAtRow:row column:column + 1];
            double d01 = [grid valueAtRow:row + 1 column:column];
            double d11 = [grid valueAtRow:row + 1 column:column + 1];

            BOOL b00 = d00 >= threshold;
            BOOL b10 = d10 >= threshold;
            BOOL b01 = d01 >= threshold;
            BOOL b11 = d11 >= threshold;

            NSMutableDictionary<NSNumber *, NSValue *> *crossings = [NSMutableDictionary dictionary];
            NSPoint p00 = [grid pointAtRow:row column:column];
            NSPoint p10 = [grid pointAtRow:row column:column + 1];
            NSPoint p01 = [grid pointAtRow:row + 1 column:column];
            NSPoint p11 = [grid pointAtRow:row + 1 column:column + 1];

            if (b00 != b10) {
                crossings[@0] = [NSValue valueWithPoint:[self interpolateThreshold:threshold pointA:p00 valueA:d00 pointB:p10 valueB:d10]];
            }
            if (b10 != b11) {
                crossings[@1] = [NSValue valueWithPoint:[self interpolateThreshold:threshold pointA:p10 valueA:d10 pointB:p11 valueB:d11]];
            }
            if (b01 != b11) {
                crossings[@2] = [NSValue valueWithPoint:[self interpolateThreshold:threshold pointA:p01 valueA:d01 pointB:p11 valueB:d11]];
            }
            if (b00 != b01) {
                crossings[@3] = [NSValue valueWithPoint:[self interpolateThreshold:threshold pointA:p00 valueA:d00 pointB:p01 valueB:d01]];
            }

            NSArray<NSNumber *> *sortedEdges = [[crossings allKeys] sortedArrayUsingSelector:@selector(compare:)];
            if (sortedEdges.count == 2) {
                [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold
                                                                           start:crossings[sortedEdges[0]].pointValue
                                                                             end:crossings[sortedEdges[1]].pointValue]];
            } else if (sortedEdges.count == 4) {
                double centerValue = (d00 + d10 + d01 + d11) / 4.0;
                BOOL centerAboveThreshold = centerValue >= threshold;
                BOOL diagonalAAbove = b00 && b11 && !b10 && !b01;
                BOOL diagonalBAbove = b10 && b01 && !b00 && !b11;

                if (diagonalAAbove) {
                    if (centerAboveThreshold) {
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@0].pointValue end:crossings[@1].pointValue]];
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@2].pointValue end:crossings[@3].pointValue]];
                    } else {
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@0].pointValue end:crossings[@3].pointValue]];
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@1].pointValue end:crossings[@2].pointValue]];
                    }
                } else if (diagonalBAbove) {
                    if (centerAboveThreshold) {
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@0].pointValue end:crossings[@3].pointValue]];
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@1].pointValue end:crossings[@2].pointValue]];
                    } else {
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@0].pointValue end:crossings[@1].pointValue]];
                        [segments addObject:[[ISOSegment alloc] initWithThreshold:threshold start:crossings[@2].pointValue end:crossings[@3].pointValue]];
                    }
                }
            }
        }
    }

    return [segments copy];
}

- (NSPoint)interpolateThreshold:(double)threshold
                         pointA:(NSPoint)pointA
                         valueA:(double)valueA
                         pointB:(NSPoint)pointB
                         valueB:(double)valueB {
    double denominator = valueB - valueA;
    double t = fabs(denominator) < DBL_EPSILON ? 0.5 : (threshold - valueA) / denominator;
    t = MIN(MAX(t, 0.0), 1.0);
    return NSMakePoint(pointA.x + (pointB.x - pointA.x) * t,
                       pointA.y + (pointB.y - pointA.y) * t);
}

@end
