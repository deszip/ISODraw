//
//  ISOSegment.h
//  ISODraw
//
//  Created by Deszip on 18/04/2026.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISOSegment : NSObject

@property (nonatomic, readonly) double threshold;
@property (nonatomic, readonly) NSPoint start;
@property (nonatomic, readonly) NSPoint end;

- (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithThreshold:(double)threshold
                            start:(NSPoint)start
                              end:(NSPoint)end NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
