//
//  ISOGridInterpolator.h
//  ISODraw
//
//  Created by Deszip on 18/04/2026.
//

#import <Foundation/Foundation.h>

#import "ISODataset.h"
#import "ISOGrid.h"

NS_ASSUME_NONNULL_BEGIN

@interface ISOGridInterpolator : NSObject

- (ISOGrid *)interpolateDataset:(ISODataset *)dataset
                                       rows:(NSInteger)rows
                                    columns:(NSInteger)columns;

@end

NS_ASSUME_NONNULL_END
