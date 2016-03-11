//
//  UIColor+Default.m
//  glufine
//
//  Created by lukay on 14-8-4.
//  Copyright (c) 2014年 lukaymail@163.com. All rights reserved.
//

#import "UIColor+Default.h"

@implementation UIColor (Default)


+ (UIColor *)badgeColor
{
    return [UIColor colorWithHexString:@"dbeef0"];
}

+ (UIColor *)lineColor
{
    return [UIColor colorWithHexString:@"e5e5e5"];
}

+ (UIColor *)grayLineColorForNavigation
{
    return [UIColor colorWithHexString:@"adadad"];
}

+ (UIColor *)navigationColor
{
    return [UIColor colorWithHexString:@"ffffff"];
}

+ (UIColor *)navigationTitleTextColor
{
    return [UIColor colorWithHexString:@"010101"];
}

+ (UIColor *)backgrounColorForAll
{
    return [UIColor colorWithHexString:@"f6f6f6"];
}

+(UIColor *)grayFontColor
{
    return [UIColor colorWithHexString:@"424242"];
}

+(UIColor *)lightGrayFontColor
{
    return [UIColor colorWithHexString:@"949494"];
}

+ (UIColor *)redFontColor
{
    return [UIColor colorWithHexString:@"ff0024"];
}

+ (UIColor *)redButtonColor
{
    return  [UIColor colorWithHexString:@"ff4b49"];
}

+ (UIColor *)greenFontColor
{
    return [UIColor colorWithHexString:@"53af40"];
}

+ (UIColor *)yellowwishBrownColor
{
    return [UIColor colorWithHexString:@"e49436"];
}

+ (UIColor *)orangeColorForHUAO
{
    return [UIColor colorWithHexString:@"ff9125"];
}

+ (UIColor*)colorWithHexString:(NSString*)string
{
    NSString *strScan=[string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scan=[NSScanner scannerWithString:strScan];
    unsigned int a;
    [scan scanHexInt:&a];
    NSString *redString=[strScan substringWithRange:NSMakeRange(0, 2)];
    NSScanner *redScan=[NSScanner scannerWithString:redString];
    unsigned int red;
    [redScan scanHexInt:&red];
    NSString *greenString=[strScan substringWithRange:NSMakeRange(2, 2)];
    NSScanner *greenScan=[NSScanner scannerWithString:greenString];
    unsigned int green;
    [greenScan scanHexInt:&green];
    NSString *blueString=[strScan substringWithRange:NSMakeRange(4, 2)];
    NSScanner *blueScan=[NSScanner scannerWithString:blueString];
    unsigned int blue;
    [blueScan scanHexInt:&blue];
    UIColor *colorRGB=[[UIColor alloc] initWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return colorRGB;
}

@end
