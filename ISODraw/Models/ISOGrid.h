//
//  ISOGrid.h
//  ISODraw
//
//  Created by Deszip on 18/04/2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISOGrid : NSObject

@property (nonatomic, readonly) NSInteger rows;
@property (nonatomic, readonly) NSInteger columns;
@property (nonatomic, readonly) double minX;
@property (nonatomic, readonly) double minY;
@property (nonatomic, readonly) double maxX;
@property (nonatomic, readonly) double maxY;
@property (nonatomic, readonly) double cellWidth;
@property (nonatomic, readonly) double cellHeight;

- (instancetype)initWithRows:(NSInteger)rows
                     columns:(NSInteger)columns
                        minX:(double)minX
                        minY:(double)minY
                        maxX:(double)maxX
                        maxY:(double)maxY;

- (void)setValue:(double)value row:(NSInteger)row column:(NSInteger)column;
- (double)valueAtRow:(NSInteger)row column:(NSInteger)column;
- (NSPoint)pointAtRow:(NSInteger)row column:(NSInteger)column;

@end

NS_ASSUME_NONNULL_END
