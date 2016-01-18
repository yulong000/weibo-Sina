//
//  YLNetworkTool.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLNetworkTool.h"
#import "AFNetworking.h"

// 网络连接超时时间
#define kNetworkRequestTimeoutInterval  15.0

@interface YLNetworkTool ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *mgr;

@end

@implementation YLNetworkTool

+ (instancetype)shareNetworkTool
{
    static YLNetworkTool *networkTool = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
       
        networkTool = [[YLNetworkTool alloc] init];
        networkTool.mgr = [AFHTTPRequestOperationManager manager];
        networkTool.mgr.requestSerializer.timeoutInterval = kNetworkRequestTimeoutInterval;
    });
    return networkTool;
}

#pragma mark 异步POST请求
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self.mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}
#pragma mark 异步POST请求, 带上传数据
- (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self.mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData) {
        for (YLFormData *formData in formDataArray) {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark 异步GET请求
- (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self.mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) {
             success(responseObject);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

#pragma mark 下载文件
- (void)downloadWithUrl:(NSString *)urlString filePath:(NSString *)filePath progress:(void (^)(float))progress success:(void (^)(id))success failure:(void(^)(NSError *))failure
{
    NSFileManager *mng = [NSFileManager defaultManager];
    if([mng fileExistsAtPath:[filePath stringByDeletingLastPathComponent]] == NO)
    {
        if([mng createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:NULL])
        {
            YLLog(@"创建文件夹成功 -- %@", filePath.stringByDeletingLastPathComponent);
        }
    }
    //初始化队列
    NSOperationQueue *queue = [[NSOperationQueue alloc ]init];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc]initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    requestOperation.outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    
    // 进度百分比
    [requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        
        if(progress)
        {
            progress(totalBytesRead * 1.0 / totalBytesExpectedToRead);
            YLLog(@"download : %lld  total : %lld", totalBytesRead, totalBytesExpectedToRead);
        }
    }];
    
    // 下载完成或失败
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(success)
        {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(failure)
        {
            failure(error);
        }
    }];
    //开始下载
    [queue addOperation:requestOperation];
}

@end



/**
 *  用来封装文件数据的模型
 */
@implementation YLFormData

@end