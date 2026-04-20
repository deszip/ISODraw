//
//  ISOGrid.m
//  ISODraw
//
//  Created by Deszip on 18/04/2026.
//

#import "ISOGrid.h"

@interface ISOGrid ()

//@property (nonatomic, strong) NSMutableData *storage;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *storage;

@end

@implementation ISOGrid

- (instancetype)initWithRows:(NSInteger)rows
                     columns:(NSInteger)columns
                        minX:(double)minX
                        minY:(double)minY
                        maxX:(double)maxX
                        maxY:(double)maxY {
    self = [super init];
    if (self) {
        _rows = MAX(rows, 2);
        _columns = MAX(columns, 2);
        _minX = minX;
        _minY = minY;
        _maxX = maxX;
        _maxY = maxY;
        _cellWidth = (_maxX - _minX) / (double)(_columns - 1);
        _cellHeight = (_maxY - _minY) / (double)(_rows - 1);
        
        NSInteger valueCount = _rows * _columns;
        _storage = [NSMutableArray arrayWithCapacity:valueCount];
        for (NSInteger index = 0; index < valueCount; index++) {
            [_storage addObject:@0.0];
        }
    }
    return self;
}

- (NSInteger)indexForRow:(NSInteger)row column:(NSInteger)column {
    return row * self.columns + column;
}

- (void)setValue:(double)value row:(NSInteger)row column:(NSInteger)column {
    self.storage[[self indexForRow:row column:column]] = @(value);
}

- (double)valueAtRow:(NSInteger)row column:(NSInteger)column {
    return self.storage[[self indexForRow:row column:column]].doubleValue;
}

- (NSPoint)pointAtRow:(NSInteger)row column:(NSInteger)column {
    return NSMakePoint(self.minX + self.cellWidth * column, self.minY + self.cellHeight * row);
}

@end
