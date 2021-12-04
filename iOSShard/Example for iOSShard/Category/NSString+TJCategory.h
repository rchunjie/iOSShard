//
//  NSString+TJCategory.h
//  iOSShard
//
//  Created by 任春节 on 2021/12/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TJCategory)
- (NSString *)MD5;

- (NSString *)hmacSha1:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
