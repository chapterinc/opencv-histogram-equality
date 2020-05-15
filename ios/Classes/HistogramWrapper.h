//
//  HistogramWrapper.h
//  Sorted
//
//  Created by Grigori on 1/21/20.
//  Copyright © 2020 Sorted. All rights reserved.
//
#ifdef __cplusplus
#undef NO
#import <opencv2/opencv.hpp>
#import <opencv2/stitching/detail/blenders.hpp>
#import <opencv2/stitching/detail/exposure_compensate.hpp>
#endif

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistogramWrapper : NSObject
+ (float)similarity:(UIImage *)input source:(UIImage *)source;
@end

NS_ASSUME_NONNULL_END
