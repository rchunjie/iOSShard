//
//  TJDemoDataSources.m
//  TJInsuranceAcceptance_Example
//
//  Created by 任春节 on 2021/11/9.
//  Copyright © 2021 rencj. All rights reserved.
//

#import "TJDemoDataSources.h"
#import "TJPushDemoModel.h"

@implementation TJDemoDataSources
+ (NSArray<TJPushDemoModel *> *)demoDataSources{
    NSMutableArray *demos = @[].mutableCopy;
    [demos addObject:[TJPushDemoModel configVCName:@"TJLicenseInfoController" params:@{} showName:@"车牌信息" showSubTitle:@"高亮文本图文混排" callBack:nil]];
    [demos addObject:[TJPushDemoModel configVCName:@"TJTextFiledViewController" params:@{} showName:@"TextFiled" showSubTitle:@"TextFiled文字限定" callBack:nil]];
    [demos addObject:[TJPushDemoModel configVCName:@"RHScanViewController" params:@{
        @"isVideoZoom":@YES,
        @"isOpenInterestRect":@YES
    } showName:@"扫描二维码" showSubTitle:@"扫描二维码逻辑" callBack:nil]];
    [demos addObject:[TJPushDemoModel configVCName:@"TJXibTapController" params:@{} showName:@"xib添加手势" showSubTitle:@"" callBack:nil]];
    [demos addObject:[TJPushDemoModel configVCName:@"TJDataSourceController" params:@{} showName:@"数据控制器" showSubTitle:@"关于数据的控制器" callBack:nil]];
    return demos;
}
@end
