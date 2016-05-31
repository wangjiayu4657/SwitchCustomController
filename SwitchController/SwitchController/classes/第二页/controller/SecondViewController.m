//
//  SecondViewController.m
//  SwitchController
//
//  Created by fangjs on 16/5/27.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "SecondViewController.h"
#import "InternationalViewController.h"
#import "MilitaryViewController.h"
#import "SocialViewController.h"
#import "PoliticalViewController.h"
#import "EconomicViewController.h"
#import "SportsViewController.h"
#import "EntertainmentViewController.h"






@interface SecondViewController ()

/**titleScrollView*/
@property (strong , nonatomic) UIScrollView *titleScrollView;

/**contentScrollView*/
@property (strong , nonatomic) UIScrollView *contentScrollView;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];

    [self setUpScrollView];
    
    [self setUpChildController];
    
    [self setUpTitle];
}


- (void) setUpScrollView {
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    self.titleScrollView.backgroundColor = [UIColor redColor];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    self.titleScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.titleScrollView];
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44)];
    self.contentScrollView.backgroundColor = [UIColor greenColor];
//    self.contentScrollView.showsHorizontalScrollIndicator = NO;
//    self.contentScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.contentScrollView];
}

- (void) setUpTitle {
   
    CGFloat labelX = 0;
    CGFloat labelW = 100;
    CGFloat labelH = 44;
    for (NSInteger i = 0; i < 7; i++) {
        UILabel *label = [[UILabel alloc] init];
        labelX = i * labelW;
        label.text = [self.childViewControllers[0] title];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(labelX, 0, labelW, labelH);
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelCilck:)];
        [label addGestureRecognizer:tap];
        label.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
        [self.titleScrollView addSubview:label];
    }
    self.titleScrollView.contentSize = CGSizeMake(7 * labelW, 0);
    self.contentScrollView.contentSize = CGSizeMake(7 * ScreenWidth, 0);
}

- (void) setUpChildController {
    InternationalViewController *internationalVC = [[InternationalViewController alloc] init];
    internationalVC.title = @"国际";
    [self.contentScrollView addSubview:internationalVC.view];
//    [self addChildViewController:internationalVC];
    
    MilitaryViewController *militaryVC = [[MilitaryViewController alloc] init];
    militaryVC.title = @"军事";
    [self addChildViewController:militaryVC];
    
    SocialViewController *socialVC = [[SocialViewController alloc] init];
    socialVC.title = @"社会";
    [self addChildViewController:socialVC];
    
    PoliticalViewController *politicalVC = [[PoliticalViewController alloc] init];
    politicalVC.title = @"政治";
    [self addChildViewController:politicalVC];
    
    EconomicViewController *economicVC = [[EconomicViewController alloc] init];
    economicVC.title = @"经济";
    [self addChildViewController:economicVC];
    
    SportsViewController *sportsVC = [[SportsViewController alloc] init];
    sportsVC.title = @"体育";
    [self addChildViewController:sportsVC];
    
    EntertainmentViewController *entertainmentVC = [[EntertainmentViewController alloc] init];
    entertainmentVC.title = @"娱乐";
    [self addChildViewController:entertainmentVC];
    
}


- (void) labelCilck:(UITapGestureRecognizer *) tap {
    NSLog(@"labelCilck");
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
