//
//  UIColor+Default.h
//  glufine
//
//  Created by lukay on 14-8-4.
//  Copyright (c) 2014年 lukaymail@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Default)

+ (UIColor*)colorWithHexString:(NSString*)string;


+(UIColor *)grayFontColor;
+(UIColor *)lightGrayFontColor;
+ (UIColor *)redFontColor;
+ (UIColor *)redButtonColor;
+ (UIColor *)greenFontColor;
+ (UIColor *)yellowwishBrownColor;
+ (UIColor *)orangeColorForHUAO;

+ (UIColor *)badgeColor;
+ (UIColor *)grayLineColorForNavigation;
+ (UIColor *)lineColor;
+ (UIColor *)backgrounColorForAll;//基色调
+ (UIColor *)navigationColor;//白色
+ (UIColor *)navigationTitleTextColor;//近似黑色


@end
