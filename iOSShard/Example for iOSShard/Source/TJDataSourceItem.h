//
//  TJDataSourceItem.h
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TJPushDemoModel;
@interface TJDataSourceItem : NSObject
+ (NSArray <TJPushDemoModel *>*)demoDataSourcesCallBack:(void(^)(TJPushDemoModel *))callBack;
@end

NS_ASSUME_NONNULL_END
