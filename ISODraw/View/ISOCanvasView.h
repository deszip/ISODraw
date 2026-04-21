//
//  ISOCanvasView.h
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import <Cocoa/Cocoa.h>

#import "ISODataset.h"
#import "ISOSegment.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISOCanvasView : NSView

@property (assign, nonatomic) NSUInteger gridResolution;
@property (nonatomic, strong, nullable) ISODataset *dataset;
@property (nonatomic, strong, nullable) NSArray <ISOSegment *> *segments;

@end

NS_ASSUME_NONNULL_END
