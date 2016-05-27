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



@interface HomeViewController ()

/**当前正在显示的控制器*/
@property (strong , nonatomic) UIViewController *showingController;

/***/
@property (strong , nonatomic) UIView *contentView;


@end

@implementation HomeViewController

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
//    animation.type = kCATransitionPush;

    [self.contentView.layer addAnimation:animation forKey:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
