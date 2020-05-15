//
//  HistogramWrapper.m
//  Shuffle
//
//  Created by Grigori on 8/8/19.
//  Copyright © 2019 Shuffle. All rights reserved.
//
#import "HistogramWrapper.h"
#import <UIKit/UIKit.h>

using namespace std;
using namespace cv;

@implementation HistogramWrapper
    
#pragma mark Public
+ (float)similarity:(UIImage *)input source:(UIImage *)source {
    Mat inputMat = [HistogramWrapper _matFrom:input];
    Mat sourceMap = [HistogramWrapper _matFrom:source];
    return [HistogramWrapper imageCompare:inputMat src_test1:sourceMap];
}
    
#pragma mark Private
    
+ (Mat)_matFrom:(UIImage *)source {
    CGImageRef imageRef = CGImageCreateCopy(source.CGImage);
    CGFloat cols = CGImageGetWidth(imageRef);
    CGFloat rows = CGImageGetHeight(imageRef);
    Mat result(rows, cols, CV_8UC4);
    
    CGBitmapInfo bitmapFlags = kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = result.step[0];
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGContextRef context = CGBitmapContextCreate(result.data, cols, rows, bitsPerComponent, bytesPerRow, colorSpace, bitmapFlags);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, cols, rows), imageRef);
    CGContextRelease(context);
    CGImageRelease(imageRef);

    return result;
}
    
+ (UIImage *)_imageFrom:(Mat)source {
    
    NSData *data = [NSData dataWithBytes:source.data length:source.elemSize() * source.total()];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    CGBitmapInfo bitmapFlags = kCGImageAlphaNone | kCGBitmapByteOrderDefault;
    size_t bitsPerComponent = 8;
    size_t bytesPerRow = source.step[0];
    CGColorSpaceRef colorSpace = (source.elemSize() == 1 ? CGColorSpaceCreateDeviceGray() : CGColorSpaceCreateDeviceRGB());
    
    CGImageRef image = CGImageCreate(source.cols, source.rows, bitsPerComponent, bitsPerComponent * source.elemSize(), bytesPerRow, colorSpace, bitmapFlags, provider, NULL, false, kCGRenderingIntentDefault);
    UIImage *result = [UIImage imageWithCGImage:image];
    
    CGImageRelease(image);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return result;
}
    
+ (float)imageCompare:(Mat) src_base src_test1:(Mat) src_test1 {
    Mat hsv_base;
    Mat hsv_test1;
    
    /// Convert to HSV
    cvtColor( src_base, hsv_base, COLOR_BGR2HSV );
    cvtColor( src_test1, hsv_test1, COLOR_BGR2HSV );
    
    /// Using 50 bins for hue and 60 for saturation
    int h_bins = 50; int s_bins = 60;
    int histSize[] = { h_bins, s_bins };
    
    // hue varies from 0 to 179, saturation from 0 to 255
    float h_ranges[] = { 0, 180 };
    float s_ranges[] = { 0, 256 };
    
    const float* ranges[] = { h_ranges, s_ranges };
    
    // Use the o-th and 1-st channels
    int channels[] = { 0, 1 };
    
    /// Histograms
    MatND hist_base;
    MatND hist_half_down;
    MatND hist_test1;
    MatND hist_test2;
    
    /// Calculate the histograms for the HSV images
    calcHist( &hsv_base, 1, channels, Mat(), hist_base, 2, histSize, ranges, true, false );
    normalize( hist_base, hist_base, 0, 1, NORM_MINMAX, -1, Mat() );
    
    calcHist( &hsv_test1, 1, channels, Mat(), hist_test1, 2, histSize, ranges, true, false );
    normalize( hist_test1, hist_test1, 0, 1, NORM_MINMAX, -1, Mat() );
    
    float bestBHATTACHARYYA = compareHist( hist_base, hist_test1, 3 ); // [0: 1] 0 is best
    float baseCORREL = compareHist( hist_base, hist_test1, 0 ); // [0: 1] 1 is best
    
    float calculated = ((1 - bestBHATTACHARYYA) + baseCORREL) / 2;
    return calculated;
}
    
@end
