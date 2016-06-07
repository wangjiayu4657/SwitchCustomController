//
//  SecondViewController.m
//  SwitchController
//
//  Created by fangjs on 16/5/27.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "SecondViewController.h"
#import "DownloadManager.h"

#define URLString @"http://120.25.226.186:32812/resources/videos/minion_01.mp4"

@interface SecondViewController ()

@end


@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 * 开始下载
 */
- (IBAction)startDownload:(id)sender {
    [[DownloadManager shareManager] downloadWithUrl:URLString withProgress:^(CGFloat progress) {
        NSLog(@"%f",progress);
    } Complete:^(NSError *error, NSString *filePath) {
         NSLog(@"%@  %@",filePath,error);
    }];
}

/**
 * 暂停下载
 */
- (IBAction)pauseDownload:(id)sender {
    [[DownloadManager shareManager] pauseDownload];
}

/**
 * 继续下载
 */
- (IBAction)continueDownload:(id)sender {
    [[DownloadManager shareManager] startDownload];
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




















































