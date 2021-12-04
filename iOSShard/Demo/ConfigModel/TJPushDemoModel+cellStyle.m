//
//  TJPushDemoModel+cellStyle.m
//  TJInsuranceAcceptance_Example
//
//  Created by 任春节 on 2021/11/9.
//  Copyright © 2021 rencj. All rights reserved.
//

#import "TJPushDemoModel+cellStyle.h"
#import "RMMacroDefinition.h"

@implementation TJPushDemoModel (cellStyle)
- (NSAttributedString *)showCellTitle{
    NSString *title = kTJMakeSureString(self.showName).length > 0?self.showName:self.vcsName;
    return [[NSAttributedString alloc] initWithString:title attributes:@{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
        NSForegroundColorAttributeName:UIColor.blackColor
    }];
}

- (NSAttributedString *)showCellDetailsTitle{
    NSString *details = kTJMakeSureString(self.showSubTitle).length > 0 ?self.showSubTitle:@"";
    return [[NSAttributedString alloc] initWithString:details attributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:12],
        NSForegroundColorAttributeName:UIColor.grayColor
    }];
}
@end
