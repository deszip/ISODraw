//
//  ISOPointGenerator.h
//  ISODraw
//
//  Created by Deszip on 17/04/2026.
//

#import <Foundation/Foundation.h>

#import "ISODataset.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISOPointGenerator : NSObject

- (ISODataset *)generateDatasetWithPointCount:(NSUInteger)pointCount;
    
@end

NS_ASSUME_NONNULL_END
