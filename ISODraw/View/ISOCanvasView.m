//
//  ISOCanvasView.m
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import "ISOCanvasView.h"

#import "ISOPointGenerator.h"
#import "ISOSegment.h"

@interface ISOCanvasView ()

@end

@implementation ISOCanvasView

- (void)setDataset:(ISODataset *)dataset {
    _dataset = dataset;
    [self setNeedsDisplay:YES];
}

- (void)setSegments:(NSArray<ISOSegment *> *)segments {
    _segments = segments;
    [self setNeedsDisplay:YES];
}

- (void)setGridResolution:(NSUInteger)gridResolution {
    _gridResolution = gridResolution;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSRect planeRect = NSInsetRect(self.bounds, 24.0, 24.0);
    [[NSColor whiteColor] setFill];
    [[NSBezierPath bezierPathWithRoundedRect:planeRect xRadius:14.0 yRadius:14.0] fill];
    [[NSColor colorWithCalibratedWhite:0.85 alpha:1.0] setStroke];
    NSBezierPath *border = [NSBezierPath bezierPathWithRoundedRect:planeRect xRadius:14.0 yRadius:14.0];
    border.lineWidth = 1.0;
    [border stroke];
    
    [self drawPlaneGridInRect:planeRect];
    
    [self drawPoints:self.dataset inRect:planeRect];
    
    if (self.segments) {
        [self drawSegments:self.segments inRect:planeRect];
    }
}

- (void)drawPlaneGridInRect:(NSRect)rect {
    [[NSColor colorWithCalibratedWhite:0.92 alpha:1.0] setStroke];
    for (NSInteger index = 1; index < self.gridResolution; index++) {
        CGFloat x = NSMinX(rect) + rect.size.width * index / self.gridResolution;
        CGFloat y = NSMinY(rect) + rect.size.height * index / self.gridResolution;

        NSBezierPath *vertical = [NSBezierPath bezierPath];
        [vertical moveToPoint:NSMakePoint(x, NSMinY(rect))];
        [vertical lineToPoint:NSMakePoint(x, NSMaxY(rect))];
        vertical.lineWidth = 0.5;
        [vertical stroke];

        NSBezierPath *horizontal = [NSBezierPath bezierPath];
        [horizontal moveToPoint:NSMakePoint(NSMinX(rect), y)];
        [horizontal lineToPoint:NSMakePoint(NSMaxX(rect), y)];
        horizontal.lineWidth = 0.5;
        [horizontal stroke];
    }
}

- (void)drawPoints:(ISODataset *)dataset inRect:(NSRect)rect {
    for (ISODataPoint *point in dataset.samplePoints) {
        NSPoint pointInView = [self viewPointForModelPoint:NSMakePoint(point.x, point.y) inRect:rect];
        NSRect markerRect = NSMakeRect(pointInView.x - 2.5, pointInView.y - 2.5, 5.0, 5.0);
        [[NSColor colorWithCalibratedWhite:0.18 alpha:0.85] setFill];
        [[NSBezierPath bezierPathWithOvalInRect:markerRect] fill];
        
        NSDictionary *attributes = @{
            NSFontAttributeName: [NSFont systemFontOfSize:11 weight:NSFontWeightSemibold],
            NSForegroundColorAttributeName: [NSColor blackColor]
        };
        [[NSString stringWithFormat:@"%i", (int)point.value] drawAtPoint:NSMakePoint(pointInView.x + 10.0, pointInView.y + 8.0) withAttributes:attributes];
    }

    NSPoint centerInView = [self viewPointForModelPoint:NSMakePoint(dataset.centerPoint.x, dataset.centerPoint.y) inRect:rect];
    NSRect outerRect = NSMakeRect(centerInView.x - 8.0, centerInView.y - 8.0, 16.0, 16.0);
    [[NSColor colorWithCalibratedRed:0.90 green:0.24 blue:0.20 alpha:1.0] setFill];
    [[NSBezierPath bezierPathWithOvalInRect:outerRect] fill];

    [[NSColor whiteColor] setStroke];
    NSBezierPath *ring = [NSBezierPath bezierPathWithOvalInRect:outerRect];
    ring.lineWidth = 2.0;
    [ring stroke];

    NSDictionary *attributes = @{
        NSFontAttributeName: [NSFont systemFontOfSize:11 weight:NSFontWeightSemibold],
        NSForegroundColorAttributeName: [NSColor blackColor]
    };
    [@"100" drawAtPoint:NSMakePoint(centerInView.x + 10.0, centerInView.y + 8.0) withAttributes:attributes];
}

- (void)drawSegments:(NSArray<ISOSegment *> *)segments inRect:(NSRect)rect {
    for (ISOSegment *segment in segments) {
        NSBezierPath *path = [NSBezierPath bezierPath];
        path.lineWidth = 2.2;
        path.lineCapStyle = NSLineCapStyleButt;
        NSPoint startPoint = [self viewPointForModelPoint:segment.start inRect:rect];
        NSPoint endPoint = [self viewPointForModelPoint:segment.end inRect:rect];
        [path moveToPoint:startPoint];
        [path lineToPoint:endPoint];
        NSColor *strokeColor = [self colorForValue:segment.threshold alpha:0.95];
        [strokeColor setStroke];
        [path stroke];

        [[strokeColor colorWithAlphaComponent:0.85] setFill];
        [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(startPoint.x - 1.5, startPoint.y - 1.5, 3.0, 3.0)] fill];
        [[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(endPoint.x - 1.5, endPoint.y - 1.5, 3.0, 3.0)] fill];
    }
}


#pragma mark - Helpers

- (NSPoint)viewPointForModelPoint:(NSPoint)point inRect:(NSRect)rect {
    double clampedX = MIN(MAX(point.x, 0.0), 1.0);
    double clampedY = MIN(MAX(point.y, 0.0), 1.0);
    return NSMakePoint(NSMinX(rect) + clampedX * rect.size.width,
                       NSMinY(rect) + clampedY * rect.size.height);
}

- (NSColor *)colorForValue:(double)value alpha:(double)alpha {
    double normalizedValue = MIN(MAX(value / 100.0, 0.0), 1.0);
    double hue = 0.62 - normalizedValue * 0.62;
    return [NSColor colorWithHue:hue saturation:0.80 brightness:0.95 alpha:alpha];
}

@end
