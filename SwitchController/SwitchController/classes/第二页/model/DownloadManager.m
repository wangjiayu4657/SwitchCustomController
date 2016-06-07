//
//  DownloadManager.m
//  SwitchController
//
//  Created by fangjs on 16/6/7.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "DownloadManager.h"
#import "NSString+Hash.h"

//文件的地址
#define fileURL self.url
//通过文件网址进行 MD5加密后作为文件名,可以保证文件名不会重复
#define fileName fileURL.md5String
// 文件的存放路径（caches）
#define filePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName]
//当前文件下载总长度的存储路径
#define totalLengthFullPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"totalLength.plist"]
//当前文件下载的长度
#define downloadLength [[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil][NSFileSize] integerValue]

@interface DownloadManager()<NSURLSessionDataDelegate>

/**
 * NSURLSession
 */
@property (strong , nonatomic) NSURLSession *session;

/**
 * NSURLSessionDataTask 下载任务
 */
@property (strong , nonatomic) NSURLSessionDataTask *dataTask;

/**
 * NSOutputStream: 写文件的流对象
 */
@property (strong , nonatomic) NSOutputStream *outputStream;

/** 
 * 进度
 */
@property (assign, nonatomic) CGFloat progress;

/**
 *  文件的总长度
 */
@property (assign, nonatomic) NSInteger totalLength;

/**
 *  URL
 */
@property (strong , nonatomic) NSString *url;

@end


@implementation DownloadManager

+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    static DownloadManager *manger = nil;
    dispatch_once(&onceToken, ^{
        manger = [[DownloadManager alloc] init];
    });
    return manger;
}

-(NSURLSession *)session{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}

-(NSOutputStream *)outputStream{
    if (!_outputStream) {
        _outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];//如果找不到该目录则会自动创建一个目录
    }
    return _outputStream;
}

/**
 *  创建任务
 */
-(NSURLSessionDataTask *)dataTask{
    if (!_dataTask) {
        NSInteger totalLength = [[NSDictionary dictionaryWithContentsOfFile:totalLengthFullPath][fileName] integerValue];
        //如果文件已下载完毕则不再进行网络请求
        if (totalLength && downloadLength == totalLength){
            NSLog(@"文件已经下载完成");
            return nil;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        NSString *range = [NSString stringWithFormat:@"bytes=%zd-",downloadLength];
       [request setValue:range forHTTPHeaderField:@"Range"];
        
        //创建一个 data 任务
        _dataTask = [self.session dataTaskWithRequest:request];
    }
    return _dataTask;
}


- (void) downloadWithUrl:(NSString *)url withProgress:(progress)progress Complete:(complete)complete {
     self.url = url;
    [self.dataTask resume];
    myProgress = progress;
    myComplete = complete;
}

- (void)continueToDownload {
    [self.dataTask resume];
}

- (void)pauseToDownload {
    [self.dataTask suspend];
}

#pragma mark - <NSURLSessionDataDelegate>

/**
 *  收到响应
 */
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSHTTPURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [self.outputStream open];
    
    self.totalLength = [response.allHeaderFields[@"Content-Length"] integerValue] + downloadLength;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:totalLengthFullPath];
    if(dictionary == nil) dictionary = [NSMutableDictionary dictionary];
    dictionary[fileName] = @(self.totalLength);
    [dictionary writeToFile:totalLengthFullPath atomically:YES];
    
    completionHandler(NSURLSessionResponseAllow);
}

/**
 * 接收单服务器传回的数据(这个方法可能会被调 N 次)
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.outputStream write:data.bytes maxLength:data.length];
    self.progress = 1.0 * downloadLength / self.totalLength;
    
    if (myProgress) {
        myProgress(self.progress);
    }
}

/**
 * 请求完毕(成功或失败)
 */
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    [self.outputStream close];
     self.outputStream = nil;
    
    if (myComplete) {
        myComplete(error,filePath);
    }

}







@end
