//
//  ISOMarchingSquaresBuilder.h
//  ISODraw
//
//  Created by Deszip on 19/04/2026.
//

#import <Foundation/Foundation.h>

#import "ISOSegment.h"
#import "ISOGrid.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISOMarchingSquaresBuilder : NSObject

- (NSArray<ISOSegment *> *)buildSegmentsForGrid:(ISOGrid *)grid thresholds:(NSArray<NSNumber *> *)thresholds;

@end

NS_ASSUME_NONNULL_END
