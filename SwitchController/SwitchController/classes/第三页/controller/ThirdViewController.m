//
//  ThirdViewController.m
//  SwitchController
//
//  Created by fangjs on 16/5/27.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "ThirdViewController.h"
#import "NSObject+Extension.h"


@interface ThirdViewController () <UIWebViewDelegate>

/**webView*/
@property (strong , nonatomic) UIWebView *webview;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webview = [[UIWebView alloc] init];
    self.webview.delegate = self;
    self.webview.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"]]];
    [self.view addSubview:self.webview];
    
    [self performSelector:@selector(call:) withObjects:@[@"12345678"]];
    
}

- (void) run {
    NSLog(@"%s",__func__);
}

- (void) call:(NSString *) number {
    NSLog(@"%s  %@",__func__,number);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIWebViewDelegate>
//js 与 oc 交互只能通过该方法(js 调用 oc)
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSLog(@"%@",url);
    
    NSString *scheme = @"xmg://";
    if ([url containsString:scheme]) {
        //或的协议后面的路径, path = sendMessage_number2_?&800
        NSString *path = [url substringFromIndex:scheme.length];
        //利用?进行切割
        NSArray *subPaths = [path componentsSeparatedByString:@"?"];
        //方法名 methodName = sendMessage_number2:
        NSString *methodName = [[subPaths firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        NSArray *params = nil;
        if (subPaths.count == 2) {
           params = [[subPaths lastObject] componentsSeparatedByString:@"&"];
            NSLog(@"%@",params);
        }
        [self performSelector:NSSelectorFromString(methodName) withObjects:params];
        
        return NO;
    }
    
    
    
    return YES;
}

/*
===========================================================================================================================
@try {
    
}
@catch (NSException *exception) {
    
}
@finally {
    
}
===========================================================================================================================
*/
 /*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
