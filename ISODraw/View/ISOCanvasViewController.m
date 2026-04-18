//
//  ISOCanvasViewController.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISOCanvasViewController.h"

#import "ISOPointGenerator.h"
#import "ISODataset.h"

#import "ISOCanvasView.h"

@interface ISOCanvasViewController ()

@property (strong, nonatomic) ISOPointGenerator *pointGenerator;
@property (strong, nonatomic) ISODataset *dataset;

@property (weak) IBOutlet ISOCanvasView *canvasView;

@end

@implementation ISOCanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pointGenerator = [ISOPointGenerator new];
    
    [self regenerateDataset];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRun:) name:@"iso_generate_dataset" object:nil];
}

- (void)handleRun:(NSNotification *)notification {
    [self regenerateDataset];
}

- (void)regenerateDataset {
    self.dataset = [self.pointGenerator generateDatasetWithPointCount:100];
    [self.canvasView setDataset:self.dataset];
}

@end
