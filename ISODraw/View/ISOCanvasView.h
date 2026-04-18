//
//  ISOCanvasView.h
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import <Cocoa/Cocoa.h>

#import "ISODataset.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISOCanvasView : NSView

@property (nonatomic, strong, nullable) ISODataset *dataset;

@end

NS_ASSUME_NONNULL_END
