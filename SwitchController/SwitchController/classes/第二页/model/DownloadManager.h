//
//  DownloadManager.h
//  SwitchController
//
//  Created by fangjs on 16/6/7.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^complete)(NSError *error, NSString *filePath);
typedef void(^progress)(CGFloat progress);


@interface DownloadManager : NSObject
{
    complete myComplete;
    progress myProgress;
}

+ (instancetype) shareManager;


- (void) downloadWithUrl:(NSString *) url;

/**
 *  文件下载
 *
 *  @param url      文件地址
 *  @param progress 下载进度
 *  @param complete 下载完毕后要执行的操作
 */
- (void) downloadWithUrl:(NSString *)url withProgress:(progress)progress Complete:(complete) complete;

/**
 * 开始下载
 */
- (void) startDownload;

/**
 * 暂停下载
 */
- (void) pauseDownload;







@end
