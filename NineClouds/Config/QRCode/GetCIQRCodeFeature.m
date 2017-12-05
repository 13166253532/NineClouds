//
//  GetCIQRCodeFeature.m
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/19.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "GetCIQRCodeFeature.h"

@implementation GetCIQRCodeFeature
+(NSString *)getCIQRCodeFeature:(UIImage *)pickImage{
    NSArray *array = [NSArray array];
    NSString *content = [NSString string];
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSData*imageData =UIImagePNGRepresentation(pickImage);
    CIImage*ciImage = [CIImage imageWithData:imageData];
    NSArray*features = [detector featuresInImage:ciImage];
    for (CIQRCodeFeature *result in features) {
        content = result.messageString;// 这个就是我们想要的值
    }
    return content;
}
@end
