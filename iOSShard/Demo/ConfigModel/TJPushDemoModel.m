//
//  TJPushDemoModel.m
//  TJInsuranceAcceptance_Example
//
//  Created by 任春节 on 2021/11/9.
//  Copyright © 2021 rencj. All rights reserved.
//

#import "TJPushDemoModel.h"

@implementation TJPushDemoModel
/// 配置项目
/// @param name 继承 TJBaseController 控制器文件名
/// @param params 参数
/// @param showName 显示信息
/// @param showSubTitle 显示详情
/// @param callBack 是否需要回调 自己处理跳转任务
+ (instancetype)configVCName:(NSString *)name
                          params:(NSDictionary *)params
                        showName:(NSString *)showName
                    showSubTitle:(NSString *)showSubTitle
                    callBack:(void(^_Nullable)(TJPushDemoModel *item))callBack{
    TJPushDemoModel *item = [[TJPushDemoModel alloc] init];
    item.vcsName = name;
    item.params = params;
    item.showName = showName;
    item.showSubTitle = showSubTitle;
    item.selectCallback = callBack;
    return item;
}



@end
