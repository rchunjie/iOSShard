//
//  TJPushDemoModel.h
//  TJInsuranceAcceptance_Example
//
//  Created by 任春节 on 2021/11/9.
//  Copyright © 2021 rencj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TJPushDemoModel : NSObject
/// 控制器名称
@property(nonatomic,copy)    NSString *vcsName;
/// 参数
@property(nonatomic,strong)  NSDictionary *params;

/// 拓展参数
@property(nonatomic,strong)  id expand;

/// 展示名
@property (nonatomic,copy)   NSString *showName;

/// 展示详情
@property (nonatomic,copy)   NSString *showSubTitle;

/// 选中回调 如果定义 在这构建数据自己进行处理
@property (nonatomic,copy,nullable)   void(^selectCallback)(TJPushDemoModel *);


/// 配置项目
/// @param name 继承 TJBaseController 控制器文件名 不可空
/// @param params 参数 可空
/// @param showName 显示信息 可空
/// @param showSubTitle 显示详情 可空
/// @param callBack 是否需要回调 自己处理跳转任务 可空
+ (instancetype)configVCName:(NSString *)name
                          params:(NSDictionary *)params
                        showName:(NSString *)showName
                    showSubTitle:(NSString *)showSubTitle
                        callBack:(void(^ _Nullable)(TJPushDemoModel *item))callBack;


@end

NS_ASSUME_NONNULL_END
