//
//  ViewController.m
//  SwitchController
//
//  Created by fangjs on 16/5/27.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "HomeViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "MyButton.h"



@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet MyButton *testbutton;

/**当前正在显示的控制器*/
@property (strong , nonatomic) UIViewController *showingController;

/***/
@property (strong , nonatomic) UIView *contentView;


@end

@implementation HomeViewController
- (IBAction)itemAction:(UIBarButtonItem *)sender {
    for (UIView *obj in self.contentView.subviews) {
        if (![obj isKindOfClass:[UIButton class]]) {
            obj.alpha = 1.0;
            [UIView animateWithDuration:0.5 animations:^{
                obj.alpha = 0.0;
            } completion:^(BOOL finished) {
                [obj removeFromSuperview];
                obj.alpha = 1.0;
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 108, ScreenWidth, ScreenHeight - 108)];
    [self.view addSubview:self.contentView];

    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *secondtVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    
    [self addChildViewController:firstVC];
    [self addChildViewController:secondtVC];
    [self addChildViewController:thirdVC];
}

- (IBAction)btnClick:(UIButton *)sender {
    [self.showingController.view removeFromSuperview];
    
    NSInteger index = [sender.superview.subviews indexOfObject:sender];
    NSInteger currentIndex = [self.childViewControllers indexOfObject:self.showingController];
    
    self.showingController = self.childViewControllers[index];
    self.showingController.view.frame = self.contentView.bounds;
    [self.contentView addSubview:self.showingController.view];
    
    //转场动画
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5;
    animation.subtype = index > currentIndex ? kCATransitionFromLeft : kCATransitionFromRight;
    animation.type = @"oglFlip";
//  animation.type = kCATransitionPush;

    [self.contentView.layer addAnimation:animation forKey:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.contentView addSubview:self.testbutton];
}
- (IBAction)testBtn:(MyButton *)sender {
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    imageBtn.bounds = CGRectMake(0, 0, 200, 200);
    imageBtn.center = CGPointMake(100, -100);
    
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"对话框"] forState:UIControlStateNormal];
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"小孩"] forState:UIControlStateHighlighted];
    
    //将这里的 imageButton传到 MyButton 中
    sender.imageButton = imageBtn;
    
    [sender addSubview:imageBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
