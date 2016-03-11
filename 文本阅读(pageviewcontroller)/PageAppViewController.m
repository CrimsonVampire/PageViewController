//
//  PageAppViewController.m
//  Page
//
//  Created by jiapinghui on 15/9/15.
//  Copyright (c) 2015年 RJ. All rights reserved.
//

#import "PageAppViewController.h"
#import "MoreViewController.h"

#define sWidth self.view.frame.size.width
#define sHeight self.view.frame.size.height
#define sSpacing 10

@interface PageAppViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSLayoutManager *layoutManager;

@property (nonatomic, assign) BOOL transiting;

@end

@implementation PageAppViewController
@synthesize pageController = _pageController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createContentPages];
    
    // 设置UIPageViewController的配置项
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
    
    // 实例化UIPageViewController对象，根据给定的属性
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options: options];
    // 设置UIPageViewController对象的代理
    _pageController.dataSource = self;
    _pageController.delegate = self;
    // 定义“这本书”的尺寸
    [[_pageController view] setFrame:[[self view] bounds]];
    
    // 让UIPageViewController对象，显示相应的页数据。
    // UIPageViewController对象要显示的页数据封装成为一个NSArray。
    // 因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）。
    // 如果要显示2页，NSArray中，应该有2个相应页数据。
    MoreViewController *initialViewController =[self viewControllerAtIndex:0];// 得到第一页
    NSArray *viewControllers =[NSArray arrayWithObject:initialViewController];
    [_pageController setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageController];
    [self.view addSubview:_pageController.view];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.transiting = YES;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    self.transiting = NO;
}

// 初始化所有数据
- (void) createContentPages {
    // 1.读取文件中的文本
    NSError *error;
    NSString *textString = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Text" ofType:@"txt"] encoding:NSASCIIStringEncoding error:&error];
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    
    // 2.将字符串封装到TextStorage中
    NSTextStorage *storage = [[NSTextStorage alloc] initWithString:textString];
    
    // 3.为TextStorag添加一个LayoutManager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    self.layoutManager = layoutManager;
    [storage addLayoutManager:layoutManager];

    NSUInteger index = 0;
    while(YES) {
        // 4.将有准确矩形大小的TextContainer添加到LayoutManager上
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(sWidth - 20, sHeight - 20)];
        [layoutManager addTextContainer:textContainer];
        
        // 5.绑定TextContainer到TextView上
        MoreViewController *moreVC = [[MoreViewController alloc] init];
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(sSpacing, 2 * sSpacing, sWidth - 20, sHeight - 20) textContainer:textContainer];
        textView.editable = NO;
        moreVC.textLabel = textView;
        [self.dataArray addObject:moreVC];
        
        // 排版结束的判断
        NSRange range = [layoutManager glyphRangeForTextContainer:textContainer];
        index ++;
        if (index == 6) {
            break;
        }
        if (range.length + range.location == textString.length)
            break;
    }
}

// 得到相应的VC对象
- (MoreViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.dataArray count] == 0) || (index >= [self.dataArray count])) {
        return nil;
    }
    
    return [self.dataArray objectAtIndex:index];
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(MoreViewController *)viewController {
    return [self.dataArray indexOfObject:viewController];
}

#pragma mark- UIPageViewControllerDataSource
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    if (self.transiting) {
        return nil;
    }
    MoreViewController *vc = (MoreViewController *)viewController;
    [UIView animateWithDuration:0.3 animations:^{
        vc.topView.transform = CGAffineTransformIdentity;
        vc.bottomView.transform = CGAffineTransformIdentity;
        vc.isShow = NO;
    }];
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    if (self.transiting) {
        return nil;
    }
    MoreViewController *vc = (MoreViewController *)viewController;
    [UIView animateWithDuration:0.3 animations:^{
        vc.topView.transform = CGAffineTransformIdentity;
        vc.bottomView.transform = CGAffineTransformIdentity;
        vc.isShow = NO;
    }];
    
    
    [self createPageView];
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.dataArray count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (void)createPageView {
    // 4.将有准确矩形大小的TextContainer添加到LayoutManager上
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(sWidth - 20, sHeight - 20)];
    [self.layoutManager addTextContainer:textContainer];
    
    // 5.绑定TextContainer到TextView上
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(sSpacing, 2 * sSpacing, sWidth - 20, sHeight - 20) textContainer:textContainer];
    textView.editable = NO;
    moreVC.textLabel = textView;
    [self.dataArray addObject:moreVC];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
