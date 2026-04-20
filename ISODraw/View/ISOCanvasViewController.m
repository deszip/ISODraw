//
//  ISOCanvasViewController.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISOCanvasViewController.h"

#import "ISOPipeline.h"
#import "ISOCanvasView.h"

@interface ISOCanvasViewController ()

@property (strong, nonatomic) ISOPipeline *pipeline;
@property (weak) IBOutlet ISOCanvasView *canvasView;

@end

@implementation ISOCanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pipeline = [ISOPipeline new];
    
    [self regenerate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRun:) name:@"iso_generate" object:nil];
}

- (void)handleRun:(NSNotification *)notification {
    NSNumber *pointsCount = notification.userInfo[@"points_count"];
    NSNumber *gridResolution = notification.userInfo[@"grid_resolution"];
    NSNumber *useDeviation = notification.userInfo[@"use_deviation"];
    
    [self.pipeline setPointCount:pointsCount.integerValue];
    [self.pipeline setGridResolution:gridResolution.integerValue];
    
    [self regenerate];
}

- (void)regenerate {
    [self.pipeline run];
    
    [self.canvasView setDataset:self.pipeline.dataset];
    [self.canvasView setSegments:self.pipeline.segments];
}

@end
