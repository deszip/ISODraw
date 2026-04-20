//
//  ISOPipeline.h
//  ISODraw
//
//  Created by Deszip on 20/04/2026.
//

#import <Foundation/Foundation.h>

#import "ISODataset.h"
#import "ISOSegment.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISOPipeline : NSObject

@property (assign, nonatomic) NSUInteger gridResolution;
@property (assign, nonatomic) NSUInteger pointCount;
@property (assign, nonatomic) BOOL useDeviation;

@property (strong, nonatomic, readonly) ISODataset *dataset;
@property (strong, nonatomic, readonly) NSArray<ISOSegment *> *segments;

- (void)run;

@end

NS_ASSUME_NONNULL_END
