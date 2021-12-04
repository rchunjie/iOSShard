//
//  TJTextFiledViewController.m
//  iOSShard
//
//  Created by 任春节 on 2021/9/7.
//

#import "TJTextFiledViewController.h"

@interface TJTextFiledViewController ()<UITextFieldDelegate>
/// 输入控件
@property(nonatomic,strong)  UITextField *textFiled;

@end

@implementation TJTextFiledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}
/// 布局
- (void)setupView{
    [self.view addSubview:({
        _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 120, CGRectGetWidth(self.view.frame) - 40, 45)];
        _textFiled.delegate = self;
        _textFiled.backgroundColor = UIColor.redColor;
        _textFiled;
    })];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // string 长度为0 退格操作是可以操作的
    if (string.length <= 0) {
        return YES;
    }
    // 获取九宫格高亮文本Range
    UITextRange *markedRange = textField.markedTextRange;
    // 如果没有输入高亮文本处理
    if (markedRange == nil) {
        // 简单限制为输入不超过15字符
        if (textField.text.length > 15) {
            return NO;
        }
        return YES;
    }else{
        // 有高亮文本逻辑操作
        return YES;
    }
}

@end
