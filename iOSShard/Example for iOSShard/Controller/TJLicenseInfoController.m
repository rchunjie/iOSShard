//
//  ViewController.m
//  iOSShard
//
//  Created by 任春节 on 2021/9/7.
//

#import "TJLicenseInfoController.h"
#import <Masonry/Masonry.h>
#import "TJTextFiledViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+TJCategory.h"

@interface TJLicenseInfoController (){
    // 合成器 控制播放，暂停
    AVSpeechSynthesizer *_synthesizer;
    // 实例化说话的语言，说中文、英文
    AVSpeechSynthesisVoice *_voice;
}
/// 详情显示
@property(nonatomic,strong)  UILabel *detailsLabel;

@end

@implementation TJLicenseInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupData];
    
    // 实例化说话的语言，说中文
    _voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    // 要朗诵，需要一个语音合成器
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
}
/// 布局
- (void)setupView{
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:({
        _detailsLabel = [UILabel new];
        _detailsLabel.numberOfLines = 0;
        _detailsLabel;
    })];
    [_detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(@0);
        make.top.mas_equalTo(@(self.view.navBarHighly + 15));
        make.left.mas_equalTo(@60);
    }];
}
/// 数据获取
- (void)setupData{
    /**
     为了解决动态图片数据 例如车牌号图片 车牌号后面紧跟文字信息 布局问题
     解决方法：NSAttributedString 图文混排
     */
    NSMutableAttributedString *detailsAttributedString = [[NSMutableAttributedString alloc] init];
    // 需要转换成图片的View
    UILabel *infoLabel = [self _getLabelDetailsText:@"浙A·888888" backColor:UIColor.blueColor];
    // 转换后的图片
    UIImage *image = [infoLabel screenshots];
    if (image) {
        // 富文本添加车牌号图片
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        // 0 水平不偏移 -3 向下偏移3个像素
        attachment.bounds = CGRectMake(0, -3, image.size.width, image.size.height);
        attachment.image = image;
        [detailsAttributedString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    }
    // 图片后跟的信息
    [detailsAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"我是详细介绍，我就不意义阐述我的信息了，如果需要知道介绍内容，请展开自己的联想"]];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    style.paragraphSpacing = 15;
    
    self.detailsLabel.attributedText = detailsAttributedString.copy;
}

// 构建需要转换图片的View
- (UILabel *)_getLabelDetailsText:(NSString *)text backColor:(UIColor *)color{
    UILabel *lable = [UILabel new];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *lableAttributedString = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:UIColor.whiteColor,NSParagraphStyleAttributeName:style}];
    CGFloat labelWidth = ceil([lableAttributedString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 21) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.width) + 1;
    lable.frame = CGRectMake(0, 0, labelWidth + 10, 21);
    lable.backgroundColor = color;
    lable.layer.cornerRadius = 3;
    lable.clipsToBounds = YES;
    lable.attributedText = lableAttributedString.copy;
    return lable;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self _readingAloudDetaileLabelInfo];
}

// 朗读Details信息
- (void)_readingAloudDetaileLabelInfo{
    // 3. 实例化发声对象 AVSpeechUtterance，指定要朗读的内容
    // 朗诵文本框中的内容
    // 实例化发声的对象，及朗读的内容
    //合成器的说话内容 可以控制说话的语速 等
   AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.detailsLabel.attributedText.string];
    // 4.指定语音，和朗诵速度
    //    中文朗诵速度：0.1还能够接受
    //   英文朗诵速度：0.3还可以
    utterance.voice = _voice;
    utterance.rate = 0.5;
    //设置音量
    utterance.volume = 0.6;
    // 5.启动
    [_synthesizer speakUtterance:utterance];
}

@end
