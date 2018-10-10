//
// Created by Cool on 2018/9/12.
// Copyright (c) 2018 Cool. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TransactionInfo : NSObject
@property(nonatomic, strong) NSString *wif;
@property(nonatomic, assign) int64_t amountAmount;
@property(nonatomic, strong) NSString *amountAssetId;

@property(nonatomic, assign) int64_t feeAmount;
@property(nonatomic, strong) NSString *feeAssetId;

@property(nonatomic, strong) NSString *from;
@property(nonatomic, strong) NSString *to;

@property(nonatomic, assign) int64_t refBlockNum;
@property(nonatomic, assign) int64_t refBlockPrefix;

@end