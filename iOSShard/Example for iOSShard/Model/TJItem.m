//
//  TJItem.m
//  TJSSS
//
//  Created by 任春节 on 2021/12/3.
//

#import "TJItem.h"

@implementation TJItem

- (NSInteger)e{
    if (_idx == 3) {
        return 2;
    }
    if (_idx == 2) {
        return 3;
    }
    if (_idx == 0) {
        return 4;
    }
    if (_idx == 4) {
        return 0;
    }
    return _idx;
}

@end
