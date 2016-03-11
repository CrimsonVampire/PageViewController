//
//  MoreViewController.m
//  Page
//
//  Created by jiapinghui on 15/9/15.
//  Copyright (c) 2015年 RJ. All rights reserved.
//

#import "MoreViewController.h"
#import "UIColor+Default.h"
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@interface MoreViewController ()

@property (nonatomic, strong) NSTextContainer *textContainer;

@end

@implementation MoreViewController
@synthesize textLabel   =   _textLabel;

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //UIStatusBarStyleDefault = 0 黑色文字，浅色背景时使用
    //UIStatusBarStyleLightContent = 1 白色文字，深色背景时使用
}

- (BOOL)prefersStatusBarHidden
{
    return YES; //返回NO表示要显示，返回YES将hiden
}

- (void)loadView{
    [super loadView];
//    self.textLabel = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, self.view.frame.size.height - 20)];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setTextLabel:(UITextView *)textLabel {
    _textLabel = textLabel;
    [self.view addSubview:_textLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, -70, self.view.frame.size.width, 70)];
    topView.backgroundColor = [UIColor colorWithHexString:@"#2B2B2A"];
    self.topView = topView;
    [[[UIApplication sharedApplication].delegate window] addSubview:topView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.backgroundColor = [UIColor yellowColor];
    backBtn.frame = CGRectMake(20, 25, 30, 30);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backBtn];
    
    //
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 60)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#2B2B2A"];
    self.bottomView = bottomView;
    [[[UIApplication sharedApplication].delegate window] addSubview:bottomView];
    
    UIView *tapView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, self.view.frame.size.width - 120, self.view.frame.size.height)];
    tapView.backgroundColor = [UIColor clearColor];
    [self.textLabel addSubview:tapView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [tapView addGestureRecognizer:tap];
}

- (void)tapAction {
    if (!self.isShow) {
        [UIView animateWithDuration:0.3 animations:^{
            self.isShow = YES;
            self.topView.transform = CGAffineTransformMakeTranslation(0, 70);
            self.bottomView.transform = CGAffineTransformMakeTranslation(0, -60);
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            self.isShow = NO;
            self.topView.transform = CGAffineTransformIdentity;
            self.bottomView.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)backAction {
    self.isShow = NO;
    self.topView.transform = CGAffineTransformIdentity;
    self.bottomView.transform = CGAffineTransformIdentity;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
