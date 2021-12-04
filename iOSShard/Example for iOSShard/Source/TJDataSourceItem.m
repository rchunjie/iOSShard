//
//  TJDataSourceItem.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "TJDataSourceItem.h"
#import "TJPushDemoModel.h"
@implementation TJDataSourceItem
+ (NSArray <TJPushDemoModel *>*)demoDataSourcesCallBack:(void(^)(TJPushDemoModel *))callBack{
    NSMutableArray *demos = @[].mutableCopy;
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"交换排序" showSubTitle:@"_exchangeSort" callBack:callBack]];;
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"根据plist文件去重排序" showSubTitle:@"_plistToRemoveDoubleSort" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"获取Documents文件夹" showSubTitle:@"_getDocementsPath" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"获取临时文件夹" showSubTitle:@"_getTempPath" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"持久化数组" showSubTitle:@"_persistentData" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"比较两站图片是不是同一张" showSubTitle:@"_compareThePictureToWhetherItIsApicture" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"震动及播放系统声音" showSubTitle:@"_vibrationAndSoundSystem" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"NSPredicate 某某开头 某某结尾 包含" showSubTitle:@"_predicateInclusionRelation" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"判断是不是ARC环境" showSubTitle:@"_determineIfItIsAnARCEnvironment" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"push跳转动画" showSubTitle:@"_pushAnimation" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"切圆角" showSubTitle:@"_roundedOperation" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"切圆角第二弹" showSubTitle:@"_imageRoundedOperation" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"阴影" showSubTitle:@"_shadowProcessing" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"添加UIStackView" showSubTitle:@"_addStackView" callBack:callBack]];
   
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"UISegmentControl" showSubTitle:@"_showSegmentControl" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"检测是否开启代理" showSubTitle:@"_getProxyStatus" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"三位一体切割" showSubTitle:@"_showChangeNumberFormat" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"注册通知" showSubTitle:@"_registerRemoteNotification" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"越狱检测" showSubTitle:@"_rootPermissions" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"监听截屏方法" showSubTitle:@"_listenForTheScreenshotMethod" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"泛型定义及使用" showSubTitle:@"_genericsDefinitionAndUsage" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"原生请求" showSubTitle:@"_originalRequest" callBack:callBack]];
    [demos addObject:[TJPushDemoModel configVCName:@"" params:@{} showName:@"获取本地IP及端口号" showSubTitle:@"_logIPAddress" callBack:callBack]];
    
    return demos;
}

@end
