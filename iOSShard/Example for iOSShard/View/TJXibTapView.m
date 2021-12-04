//
//  TJXibTapView.m
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import "TJXibTapView.h"
@interface TJXibTapView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation TJXibTapView

- (IBAction)tapImageView:(id)sender {
    NSLog(@"手势来了");
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.imageView.userInteractionEnabled = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
