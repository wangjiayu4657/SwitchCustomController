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
#import <objc/runtime.h>
#import <AFNetworking.h>


//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>

//#import "NSString+Hash.h"


@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet MyButton *testbutton;
@property (weak, nonatomic) IBOutlet UIView *topBackView;

/**当前正在显示的控制器*/
@property (strong , nonatomic) UIViewController *showingController;


@property (strong , nonatomic) UIView *contentView;


@property (strong , nonatomic) UIButton *imageBtn;


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
    
   // [self download];
     self.contentView = [[UIView alloc] init];
    [self.view addSubview:self.contentView];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.top.equalTo(self.topBackView.bottom);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
    }];

    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *secondtVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    
    [self addChildViewController:firstVC];
    [self addChildViewController:secondtVC];
    [self addChildViewController:thirdVC];
    
    UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageBtn.bounds = CGRectMake(0, 0, 200, 200);
    imageBtn.center = CGPointMake(100, -100);
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"对话框"] forState:UIControlStateNormal];
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"小孩"] forState:UIControlStateHighlighted];
    self.imageBtn = imageBtn;
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

    static BOOL show = YES;
    //将这里的 imageButton传到 MyButton 中
    if (show) {
        self.imageBtn.hidden = NO;
        sender.imageButton = self.imageBtn;
        [sender addSubview:self.imageBtn];
    }else {
        self.imageBtn.hidden = YES;
        [self.imageBtn removeFromSuperview];
    }
    show = !show;
}


//测试使用:用来练习NSURLSession的使用==================================================================================================
- (void) postRequest {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.douban.com/v2/book/reviews"]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    [task resume];
}

- (void) getRequest {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"http://api.douban.com/labs/bubbler/user/ahbei"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
    }];
    [task resume];
}

//下载大文件时,会自动下载到临时文件夹,等下载完成时,直接剪切到指定的文件夹即可
- (void) download {
    NSURLSession *sessiong = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [sessiong downloadTaskWithURL:[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *file = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"%@",file);
        [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:file] error:nil];
    }];
    
    [task resume];
}

//====================================================================================================================================

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//====================================================================================================================================
/*
    //post 请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:@"" parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

    //上传文件
    [manager POST:@"" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
*/
//====================================================================================================================================

@end
