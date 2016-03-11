//
//  ViewController.m
//  Page
//
//  Created by jiapinghui on 15/9/15.
//  Copyright (c) 2015年 RJ. All rights reserved.
//

#import "ViewController.h"
#import "PageAppViewController.h"

@interface ViewController ()

{
    UIPageViewController *pageViewController;
}

@property (nonatomic, strong)UIPageViewController *pageViewController;

@end

@implementation ViewController

@synthesize pageViewController = _pageViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    button.backgroundColor = [UIColor lightGrayColor];
    button.center = self.view.center;
    [button setTitle:@"达芬奇的密码" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction {
    PageAppViewController *pp = [[PageAppViewController alloc] init];
    [self presentViewController:pp animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
