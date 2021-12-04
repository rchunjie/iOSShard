//
//  UIView+TJCategory.h
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TJCategory)
/// 高度
@property (nonatomic,assign) CGFloat navBarHighly;
/// 获取xib相关视图
+(instancetype)loadFromNibFirst;

+(instancetype)loadFromNibLast;
// 获取view截图
- (UIImage *)screenshots;

@end

NS_ASSUME_NONNULL_END
