//
//  TJCovariantItem.h
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TJPersion : NSObject
///
@property(nonatomic,strong)  NSString *name;
@end
@interface TJCovariantItem<__covariant T> : NSObject
/// 泛型
@property(nonatomic,strong)  T dataItem;

@property (nonatomic,copy)   NSString *name;
@end

NS_ASSUME_NONNULL_END
