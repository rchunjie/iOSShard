//
//  TJDataSourceController.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "TJDataSourceController.h"
#import "TJItem.h"
#import "TJPushDemoController.h"
#import "TJPushDemoModel.h"
#import <objc/message.h>
#import "TJDataSourceItem.h"
#import "TJCategory.h"
#import <AVFoundation/AVFoundation.h>
#import "TJCovariantItem.h"
#import <Masonry/Masonry.h>
#import "TJDataSourceController+Thread.h"
#import "TJDataSourceController+UNUserNotificationCenter.h"


void (*TJDatamsgsend)(id, SEL) = (void(*)(id, SEL))objc_msgSend;
@interface TJDataSourceController ()
@end

@implementation TJDataSourceController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}
- (void)moveSubViews{
    [self _moveSubViews];
}
- (void)_moveSubViews{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag != 1001) {
                [UIView animateWithDuration:2 animations:^{
                    CGRect objFrame = obj.frame;
                    objFrame.origin.y = CGRectGetHeight(self.view.frame);
                    objFrame.origin.x = CGRectGetWidth(self.view.frame);
                    obj.frame = objFrame;
                } completion:^(BOOL finished) {
                    [obj removeFromSuperview];
                }];
            }
        }];
    });
}

- (void)setupView{
    self.navigationItem.title = @"点击触发方法";
    TJPushDemoController *vc = [[TJPushDemoController alloc] init];
    __weak __block typeof(self) wSelf = self;
    [vc setValuesForKeysWithDictionary:@{@"dataSource":[TJDataSourceItem demoDataSourcesCallBack:^(TJPushDemoModel * _Nonnull item) {
        TJDatamsgsend(wSelf,NSSelectorFromString(item.showSubTitle));
    }]}];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.bounds;
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.view.tag = 1001;
}
/// 交换排序
- (void)_exchangeSort{
    // 第一种
    NSMutableArray <TJItem *>*parts = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i ++) {
        if (i != 2) {
            TJItem *item = [[TJItem alloc] init];
            item.idx = i;
            [parts addObject:item];
        }
    }
    NSDictionary *fil = @{@"1":@"4",@"6":@"8",@"1000":@"1001"};
    [fil enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key intValue] <= parts.count || [obj intValue] <= parts.count) {
            [parts exchangeObjectAtIndex:[key intValue] withObjectAtIndex:[obj intValue]];
        }
        
    }];
    for (TJItem *item in parts) {
        NSLog(@"%ld",item.idx);
    }
    // 第二种
    NSArray *partsSorted = [parts sortedArrayUsingComparator:^NSComparisonResult(TJItem *obj1, TJItem *obj2) {
        return obj1.e > obj2.e;
    }];
    NSLog(@"%@",partsSorted);
    
}

// 根据plist文件去重排序
- (void)_plistToRemoveDoubleSort{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sourceData" ofType:@"plist"];
    if (path.length <= 0) {return;}
    NSArray <NSString *>*array = [NSArray arrayWithContentsOfFile:path];
    NSSet *set = [NSSet setWithArray:array];
    NSArray *arraySet = [set.allObjects sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 integerValue] > [obj2 integerValue];
    }];
    NSLog(@"%@",arraySet);
}
// 获取Docement文件夹
- (NSString *)_getDocementsPath{
    NSArray * pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * path = pathArr.firstObject;
    NSLog(@"%@",path);
    return path;
}
// 获取临时文件夹
- (NSString *)_getTempPath{
    NSString * path = NSTemporaryDirectory();
    NSLog(@"%@",path);
    return path;
}
// 持久化数组
- (void)_persistentData{
    NSArray * aray = @[@"456",@"123"];
    NSString *path = [self _getTempPath];
    [aray writeToFile:[path stringByAppendingPathComponent:@"123.plist"] atomically:YES];
}
// 比较两张图片是不是同一张
- (void)_compareThePictureToWhetherItIsApicture{
    NSString * pathImage1 = [[NSBundle mainBundle] pathForResource:@"13" ofType:@"png"];
    NSString * pathImage2 = [[NSBundle mainBundle] pathForResource:@"12" ofType:@"png"];
    NSData * data = [[NSData dataWithContentsOfFile:pathImage1] base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSData * data1 = [[NSData dataWithContentsOfFile:pathImage2] base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString * datastr1 = [[[NSString alloc] initWithData:data encoding:1] MD5];
    NSString * datastr2 = [[[NSString alloc] initWithData:data1 encoding:1] MD5];
    if ([datastr1 rangeOfString:datastr2].location != NSNotFound) {
        NSLog(@"是同一张");
    }else{
        NSLog(@"不是同一张");
    }
}
// 震动及播放系统声音
- (void)_vibrationAndSoundSystem{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSoundWithCompletion(1007, ^{
        
    });
    
    //    第二种播放
    //    AudioServicesPlaySystemSound(1007);//播放
    //    AudioServicesDisposeSystemSoundID(1007);//停止播放
}
// NSPredicate 某某开头 某某结尾 包含
- (void)_predicateInclusionRelation{
    // name开头为zhang
    NSPredicate * pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@",@"zhang"];
    // name 以si结尾
    pre = [NSPredicate predicateWithFormat:@"name ENDSWITH %@",@"si"];
    // name 包含g
    pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"g"];
    // like语法后面匹配si  * 在后面就匹配前面的
    pre = [NSPredicate predicateWithFormat:@"name like %@",@"*si"];
    
}

- (void)_determineIfItIsAnARCEnvironment{
# if __has_feature(objc_arc)
    NSLog(@"我是ARC环境");
#else
    NSLog(@"我是MRC环境");
#endif
}
// push跳转动画
- (void)_pushAnimation{
    TJDataSourceController *vc = [[TJDataSourceController alloc] init];
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:3];
    [self.navigationController pushViewController:vc animated:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}
// 切圆角
- (void)_roundedOperation{
    UIView *shapeView = [[UIView alloc] init];
    shapeView.backgroundColor = UIColor.redColor;
    shapeView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * 0.382 - 50, (CGRectGetHeight)(self.view.frame) * 0.382 - 50, 100, 100);
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 100, 100) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(50, 50)].CGPath;
    shapeView.layer.mask = shapeLayer;
    shapeView.layer.masksToBounds = YES;
    [self.view addSubview:shapeView];
    
    [self _moveSubViews];
}

/// 图片切圆角
- (void)_imageRoundedOperation{
    NSString * imagePath = [[NSBundle mainBundle] pathForResource:@"456" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    //2.生成一个跟图片相同大小图片上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3.在上下文添加一个圆形裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //把路径设置成裁剪区域
    [path addClip];
    //4.把图片绘制图片上下文.
    [image drawAtPoint:CGPointZero];
    //5.生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭图片上下文.
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = newImage;
    imageView.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 100) / 2, (CGRectGetHeight)(self.view.frame) * 0.382 , 100, 100);
    [self.view addSubview:imageView];
    [self _moveSubViews];
}

// 阴影处理
- (void)_shadowProcessing{
    UIView *shapeView = [[UIView alloc] init];
    shapeView.backgroundColor = UIColor.redColor;
    shapeView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * 0.382 - 50, (CGRectGetHeight)(self.view.frame) * 0.382 - 50 , 100, 100);
    //偏移距离
    shapeView.layer.shadowOffset =  CGSizeMake(1, 1);
    //透明度
    shapeView.layer.shadowOpacity = 0.5;
    //阴影颜色
    shapeView.layer.shadowColor =  [UIColor blackColor].CGColor;
    //阴影半径
    shapeView.layer.shadowRadius = 3;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(5,5, shapeView.frame.size.width, shapeView.frame.size.height ) cornerRadius:1.0];
    //阴影路径
    shapeView.layer.shadowPath = path.CGPath;
    [self.view addSubview:shapeView];
    [self _moveSubViews];
}
// 获取局域网地址
- (NSString*)_getIPAddress{
    NSDictionary *proxySettings = (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www_baidu_com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    NSDictionary *dicProxyInfo = [NSDictionary dictionaryWithObjectsAndKeys:settings,@"proxyInfo", nil];
    CFRelease((__bridge CFTypeRef)(proxies));
    if ([dicProxyInfo objectForKey:@"proxyInfo"]) {
        NSDictionary *proxyInfo = [dicProxyInfo valueForKey:@"proxyInfo"];
        NSMutableString *paramsString = [[NSMutableString alloc] init];
        if ([proxyInfo objectForKey:@"kCFProxyHostNameKey"]) {
            [paramsString appendString:[proxyInfo objectForKey:@"kCFProxyHostNameKey"]];
        }else{
            return @"";
        }
        if ([proxyInfo objectForKey:@"kCFProxyPortNumberKey"]) {
            [paramsString appendString:@":"];
            [paramsString appendString:[NSString stringWithFormat:@"%@",[proxyInfo objectForKey:@"kCFProxyPortNumberKey"]]];
        }else{
            return @"";
        }
        return paramsString.copy;
    }else{
        return @"";
    }
}

- (void)_logIPAddress{
    NSLog(@"%@",[self _getIPAddress]);
}
// 添加控件
- (void)_showSegmentControl{
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(100,80,300,40)];
    [segmentControl insertSegmentWithTitle:@"旧色调"atIndex:0 animated:YES];
    [segmentControl insertSegmentWithTitle:@"模糊设置"atIndex:1 animated:YES];
    segmentControl.selectedSegmentIndex = 1;
    [segmentControl addTarget:self action:@selector(changeIndex:)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    [self _moveSubViews];
}

- (void)changeIndex:(UISegmentedControl *)send{
    NSInteger index=send.selectedSegmentIndex;
    NSLog(@"%ld",index);
}
// 检测是否开启代理
- (BOOL)_getProxyStatus{
    NSDictionary *proxySettings =  (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    NSLog(@"host=%@", [settings objectForKey:(NSString *)kCFProxyHostNameKey]);
    NSLog(@"port=%@", [settings objectForKey:(NSString *)kCFProxyPortNumberKey]);
    NSLog(@"type=%@", [settings objectForKey:(NSString *)kCFProxyTypeKey]);
    
    if ([[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //没有设置代理
        NSLog(@"没有设置代理");
        return NO;
    }else{
        //设置代理了
        NSLog(@"设置代理了");
        return YES;
    }
}

- (void)_showChangeNumberFormat{
    NSLog(@"%@",[self _changeNumberFormat:@"10000000000"]);
}

// 三位切割字符串
-(NSString *)_changeNumberFormat:(NSString *)num{
    if (num.length== 0) {
        return @"0";
    }
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0){
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

/**
 权限检测
 
 @return YES 越狱
 */
- (BOOL)_rootPermissions{
    __block BOOL root = NO;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray <NSString *>*pathArray = @[@"/etc/ssh/sshd_config",
                                       @"/usr/libexec/ssh-keysign",
                                       @"/usr/sbin/sshd",
                                       @"/usr/sbin/sshd",
                                       @"/bin/sh",
                                       @"/bin/bash",
                                       @"/etc/apt",
                                       @"/Application/Cydia.app/",
                                       @"/Library/MobileSubstrate/MobileSubstrate.dylib"
    ];
    [pathArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        root = [fileManager fileExistsAtPath:obj];
        if (root) {
            *stop = YES;
        }
    }];
    if (root) {
        NSLog(@"越狱");
    }else{
        NSLog(@"正常");
    }
    return root;
}
// 监听截屏方法
- (void)_listenForTheScreenshotMethod{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidTakeScreenshot) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    //     [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
    //         NSLog(@"检测到截屏方法2");
    //     }];
}
-(void)userDidTakeScreenshot{
    NSLog(@"检测到截屏方法1");
    UIImage *image = [NSObject imageWithScreenshot];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:imageView];
    [self _moveSubViews];
}


- (void)_genericsDefinitionAndUsage{
    TJCovariantItem<TJPersion *> *item = [[TJCovariantItem alloc] init];
    TJPersion *p = [[TJPersion alloc] init];
    p.name = @"Persion";
    item.dataItem = p;
    item.name = @"ItemPersion";
    NSLog(@"%@_%@",item.name,item.dataItem.name);
}
/// 原生请求
- (void)_originalRequest{
    [self _firstOriginalRequest];
    [self _secondOriginalRequest];
}

- (void)_firstOriginalRequest{
    // 第一种请求
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://mdmenrollment.apple.com/devices"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    req.HTTPMethod   = @"POST";//默认是 get
    req.HTTPBody = [NSData new];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *aa = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"第一种请求");
        NSLog(@"%@",[[NSMutableString alloc] initWithData:data encoding:4]);
    }];
    [aa resume];
}

- (void)_secondOriginalRequest{
    // Do any additional setup after loading the view.
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://testysbapi.enjoy7.com/ysb/user/userLogin"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    req.HTTPMethod   = @"POST";//默认是 get
    
    NSData *data = [self _compactFormatDataForDictionary:@{@"cade":@"123456",
                                                           @"userName":@"18618423220"}];
    req.HTTPBody = data;
    //创建NSURLSessionConfiguration
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPAdditionalHeaders = @{
        @"Accept": @"application/json",
        @"Accept-Language": @"en",
        @"User-Agent": @"iPhone",
    };
    
    //设置请求超时为10秒钟
    config.timeoutIntervalForRequest = 10;
    
    //在蜂窝网络情况下是否继续请求（上传或下载）
    config.allowsCellularAccess = NO;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionTask *aa = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"第二种请求");
        NSLog(@"----------><><>%@",[[NSMutableString alloc] initWithData:data encoding:4]);
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
    }];
    [aa resume];
}
- (NSData *)_compactFormatDataForDictionary:(NSDictionary *)dicJson{
    if (![dicJson isKindOfClass:[NSDictionary class]]) {return nil;}
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:0 error:nil];
    if (![jsonData isKindOfClass:[NSData class]]) {return nil;}
    return jsonData;
}
// 添加UIStackView
- (void)_addStackView{
    UIStackView *stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    // 布局方向
    stackView.axis = UILayoutConstraintAxisHorizontal;
    // 布局填充模式
    stackView.alignment = UIStackViewAlignmentTop;
    // 间隔
    stackView.spacing = 20;
    [self.view addSubview:stackView];
    // 测试View1
    UILabel *infoLabel = [UILabel new];
    infoLabel.numberOfLines = 0;
    [stackView addArrangedSubview:infoLabel];
    // 测试View2
    UILabel *detailLabel = [UILabel new];
    [stackView addArrangedSubview:({
        detailLabel.numberOfLines = 0;
        detailLabel;
    })];
    // 横向布局控制
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.lessThanOrEqualTo(stackView).multipliedBy(0.33);
    }];
    // stackView 布局
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(@0);
        make.top.mas_equalTo(@200);
    }];
    // 提高横向布局等级
    [detailLabel setContentHuggingPriority:(UILayoutPriorityRequired) forAxis:(UILayoutConstraintAxisHorizontal)];
    detailLabel.attributedText = [[NSAttributedString alloc] initWithString:@"1212312y379183917323123123123"];
    infoLabel.attributedText = [[NSAttributedString alloc] initWithString:@"L1212312y379183917323123123123"];
    [self _moveSubViews];
}


@end
