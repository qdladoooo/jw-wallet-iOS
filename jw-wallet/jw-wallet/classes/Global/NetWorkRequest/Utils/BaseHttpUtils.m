//
// Created by FJL on 15/7/2.
// Copyright (c) 2015 orangins. All rights reserved.
//

//#import <FCUtility/AESCrypt.h>
#import "AESCrypt.h"
#import "BaseHttpUtils.h"
#import "FCUtility.h"
#import "AFURLSessionManager.h"

const static NSString *kApiVersion = @"15";

@interface BaseHttpUtils ()
@end;


@implementation BaseHttpUtils {

}

+ (BaseHttpUtils *)instance {
    static BaseHttpUtils *httpUtils = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        httpUtils = [[self alloc] init];

        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        httpUtils.optManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        httpUtils.optManager.responseSerializer = [AFJSONResponseSerializer serializer];

    });
    return httpUtils;
}

- (void)request:(NSString *)method url:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock {

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:method URLString:url parameters:params error:nil];
//    NSString *userAgent = [request valueForHTTPHeaderField:@"User-Agent"];
//    NSString *versionCode = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *) kCFBundleVersionKey]];
//    userAgent = [userAgent stringByAppendingString:[NSString stringWithFormat:@"OKchexianIOS_%@,ID/%@, ", versionCode, [Utils UUID]]];
//    [request setValue:userAgent forHTTPHeaderField:@"User-Agent"];

    NSURLSessionDataTask *dataTask = [self.optManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        [self showLog:url params:params result:responseObject];
        if (error) {
            if (errorBlock != nil)
                errorBlock(error);
        } else {
            [self result:url successBlock:successBlock failBlock:failBlock responseObject:responseObject];
        }

    }];
    [dataTask resume];

}

- (void)get:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock {

    [self request:@"GET" url:url params:params success:successBlock fail:failBlock error:errorBlock];

}

- (void)get5:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock {

    [self request:@"GET" url:url params:params success:successBlock fail:failBlock error:errorBlock];

}

- (void)post:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock {

    [self request:@"POST" url:url params:params success:successBlock fail:failBlock error:errorBlock];

}


- (void)postOnly:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock {
    [self request:@"POST" url:url params:params success:successBlock fail:failBlock error:errorBlock];
}

- (void)result:(NSString *)url successBlock:(SuccessBlock)successBlock failBlock:(FailBlock)failBlock responseObject:(id)responseObject {

    successBlock(responseObject);

}

- (void)downLoad:(NSString *)url callBack:(CompletionCallBack)callBack {
    [self downLoad:url name:nil callBack:callBack];
}

- (void)downLoad:(NSString *)url name:(NSString *)name callBack:(CompletionCallBack)callBack {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        if (![[NSFileManager defaultManager] fileExistsAtPath:AD_PATH]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:AD_PATH withIntermediateDirectories:NO attributes:nil error:nil];
        }
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *component = [documentsDirectoryURL URLByAppendingPathComponent:[NSString stringWithFormat:@"OKAD/%@", name ?: [response suggestedFilename]]];
        return component;

    }                                                       completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (callBack) {
            callBack(filePath);
        }
        NSLog(@"File downloaded to: %@", filePath);

    }];
    [downloadTask resume];
}

- (void)showLog:(NSString *)url params:(NSDictionary *)params result:(NSDictionary *)dic {

    NSLog(@"url------------->%@", url);
    NSLog(@"params------------->%@", params);
    NSLog(@"jsonResult------>%@", [FCUtility toJSONData:dic]);
}

@end
