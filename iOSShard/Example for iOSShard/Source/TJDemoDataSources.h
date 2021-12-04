//
//  TJDemoDataSources.h
//  TJInsuranceAcceptance_Example
//
//  Created by 任春节 on 2021/11/9.
//  Copyright © 2021 rencj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class TJPushDemoModel;
@interface TJDemoDataSources : NSObject
+ (NSArray <TJPushDemoModel *>*)demoDataSources;
@end

NS_ASSUME_NONNULL_END
