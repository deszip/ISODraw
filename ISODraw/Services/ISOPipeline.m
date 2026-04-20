//
//  ISOPipeline.m
//  ISODraw
//
//  Created by Deszip on 20/04/2026.
//

#import "ISOPipeline.h"

@interface ISOPipeline ()

//@property (strong, nonatomic) ISOPointGenerator *pointGenerator;

@end

@implementation ISOPipeline

//- (void)regenerateDataset {
//    self.dataset = [self.pointGenerator generateDatasetWithPointCount:100];
//    [self.canvasView setDataset:self.dataset];
//    
//    // Tresholds
//    NSMutableArray<NSNumber *> *thresholds = [NSMutableArray array];
//    for (NSInteger value = 90; value >= 10; value -= 10) {
//        [thresholds addObject:@(value)];
//    }
//    
//    NSInteger gridResolution = 100;
//    ISOGrid *grid = [self.gridInterpolator interpolateDataset:self.dataset
//                                                         rows:gridResolution
//                                                      columns:gridResolution];
//    
//    NSArray *segments = [self.marchingSquaresBuilder buildSegmentsForGrid:grid thresholds:thresholds];
//    [self.canvasView setSegments:segments];
//}

@end
