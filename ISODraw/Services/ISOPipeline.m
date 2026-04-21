//
//  ISOPipeline.m
//  ISODraw
//
//  Created by Deszip on 20/04/2026.
//

#import "ISOPipeline.h"

#import "ISOPointGenerator.h"
#import "ISOGridInterpolator.h"
#import "ISOMarchingSquaresBuilder.h"

@interface ISOPipeline ()

@property (strong, nonatomic) ISOPointGenerator *pointGenerator;
@property (strong, nonatomic) ISOGridInterpolator *gridInterpolator;
@property (strong, nonatomic) ISOMarchingSquaresBuilder *marchingSquaresBuilder;

@end

@implementation ISOPipeline

- (instancetype)init {
    self = [super init];
    if (self) {
        _gridResolution = 100;
        _pointCount = 100;
        _useDeviation = YES;
        _segments = @[];
        
        _pointGenerator = [ISOPointGenerator new];
        _gridInterpolator = [ISOGridInterpolator new];
        _marchingSquaresBuilder = [ISOMarchingSquaresBuilder new];
    }
    
    return self;
}

- (void)run {
    [self.pointGenerator setUseDeviation:self.useDeviation];
    _dataset = [self.pointGenerator generateDatasetWithPointCount:self.pointCount];
    
    // Tresholds
    NSMutableArray<NSNumber *> *thresholds = [NSMutableArray array];
    for (NSInteger value = 90; value >= 10; value -= 10) {
        [thresholds addObject:@(value)];
    }
    
    ISOGrid *grid = [self.gridInterpolator interpolateDataset:self.dataset
                                                         rows:self.gridResolution
                                                      columns:self.gridResolution];
    
    _segments = [self.marchingSquaresBuilder buildSegmentsForGrid:grid thresholds:thresholds];
}

@end
