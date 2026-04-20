//
//  ISOCanvasViewController.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISOCanvasViewController.h"

#import "ISOPointGenerator.h"
#import "ISOGridInterpolator.h"
#import "ISODataset.h"
#import "ISOGrid.h"
#import "ISOMarchingSquaresBuilder.h"

#import "ISOCanvasView.h"

@interface ISOCanvasViewController ()

@property (strong, nonatomic) ISOPointGenerator *pointGenerator;
@property (strong, nonatomic) ISOGridInterpolator *gridInterpolator;
@property (strong, nonatomic) ISOMarchingSquaresBuilder *marchingSquaresBuilder;

@property (strong, nonatomic) ISODataset *dataset;

@property (weak) IBOutlet ISOCanvasView *canvasView;

@end

@implementation ISOCanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pointGenerator = [ISOPointGenerator new];
    self.gridInterpolator = [ISOGridInterpolator new];
    self.marchingSquaresBuilder = [ISOMarchingSquaresBuilder new];
    
    [self regenerateDataset];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRun:) name:@"iso_generate_dataset" object:nil];
}

- (void)handleRun:(NSNotification *)notification {
    [self regenerateDataset];
}

- (void)regenerateDataset {
    self.dataset = [self.pointGenerator generateDatasetWithPointCount:100];
    [self.canvasView setDataset:self.dataset];
    
    // Tresholds
    NSMutableArray<NSNumber *> *thresholds = [NSMutableArray array];
    for (NSInteger value = 90; value >= 10; value -= 10) {
        [thresholds addObject:@(value)];
    }
    
    NSInteger gridResolution = 100;
    ISOGrid *grid = [self.gridInterpolator interpolateDataset:self.dataset
                                                         rows:gridResolution
                                                      columns:gridResolution];
    
    NSArray *segments = [self.marchingSquaresBuilder buildSegmentsForGrid:grid thresholds:thresholds];
    [self.canvasView setSegments:segments];
}

@end
