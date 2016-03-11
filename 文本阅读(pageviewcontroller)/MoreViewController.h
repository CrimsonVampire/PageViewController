//
//  MoreViewController.h
//  Page
//
//  Created by jiapinghui on 15/9/15.
//  Copyright (c) 2015年 RJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, retain) UITextView   *textLabel;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIView *bottomView;

@end
