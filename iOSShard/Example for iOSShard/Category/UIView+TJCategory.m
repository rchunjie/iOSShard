//
//  UIView+TJCategory.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "UIView+TJCategory.h"

@implementation UIView (TJCategory)
// 加载xib文件
+(instancetype)loadFromNibFirst{
    return [self loadFromNibArray].firstObject;
}

+(instancetype)loadFromNibLast{
    return [self loadFromNibArray].lastObject;
}

+ (NSArray *)loadFromNibArray{
    NSArray *bundleArray = [[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass(self) owner:nil options:nil];
    NSArray *manBundle = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
    return bundleArray.count > 0 ? bundleArray : manBundle;
}
- (void)setNavBarHighly:(CGFloat)navBarHighly{
}
- (CGFloat)navBarHighly{
    CGFloat statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navHeight = self.nearestNaviController.navigationBar.frame.size.height;
    return statusHeight + navHeight;
}

-(UINavigationController *)nearestNaviController{
    UIResponder *responder = self.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UINavigationController class]]) {
            break;
        }else if ([responder isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)responder;
            if (vc.navigationController) {
                responder = vc.navigationController;
                break;
            }
        }
        responder = [responder nextResponder];
    }
    return (UINavigationController *)responder;
}
-(UIViewController *)nearestViewController{
    UIResponder *responder = self.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            break;
        }else{
            responder = [responder nextResponder];
        }
    }
    return (UIViewController *)responder;
}
- (UIImage *)screenshots{
    //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.frame.size.width,self.frame.size.height), NO, 0.0);
    //呈现接受者及其子范围到指定的上下文
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    return viewImage;
}
@end
