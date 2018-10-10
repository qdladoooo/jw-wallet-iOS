//
// Created by FJL on 15/7/2.
// Copyright (c) 2015 orangins. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFURLSessionManager;

#define AD_PATH  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/OKAD"]
const static NSString *kAES = @"Lj*Lp9jdDsLXZui%";

typedef void (^SuccessBlock)(NSDictionary *dic);

typedef void (^FailBlock)(NSDictionary *dic);

typedef void (^ErrorBlock)(NSError *error);

typedef void (^CompletionCallBack)(id data);


@interface BaseHttpUtils : NSObject
@property(nonatomic, strong) AFURLSessionManager *optManager;

+ (BaseHttpUtils *)instance;

- (void)get:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock;

- (void)get5:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock;

- (void)post:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock;

- (void)postOnly:(NSString *)url params:(NSDictionary *)params success:(SuccessBlock)successBlock fail:(FailBlock)failBlock error:(ErrorBlock)errorBlock;

- (void)downLoad:(NSString *)url callBack:(CompletionCallBack)callBack;

- (void)downLoad:(NSString *)url name:(NSString *)name callBack:(CompletionCallBack)callBack;


@end