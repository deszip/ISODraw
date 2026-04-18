//
//  ISOWindowController.m
//  ISODraw
//
//  Created by Deszip on 18/04/2026.
//

#import "ISOWindowController.h"

@interface ISOWindowController ()

@end

@implementation ISOWindowController

- (IBAction)run:(NSButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"iso_generate_dataset" object:self]];
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

@end
