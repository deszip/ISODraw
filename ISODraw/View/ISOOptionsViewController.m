//
//  ISOOptionsViewController.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISOOptionsViewController.h"

@interface ISOOptionsViewController () <NSTableViewDataSource, NSTableViewDelegate>

@property (weak) IBOutlet NSTextField *pointsCountField;
@property (weak) IBOutlet NSTextField *gridResolutionField;
@property (weak) IBOutlet NSButton *deviationCheck;

@end

@implementation ISOOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)run:(id)sender {
    NSDictionary *options = @{
        @"points_count": @(self.pointsCountField.intValue),
        @"grid_resolution": @(self.gridResolutionField.intValue),
        @"use_deviation": @(self.deviationCheck.state == NSControlStateValueOn)
    };
    NSNotification *notification = [NSNotification notificationWithName:@"iso_generate" object:self userInfo:options];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
