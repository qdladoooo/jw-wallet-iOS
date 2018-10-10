//
// Created by Cool on 2018/9/13.
// Copyright (c) 2018 Cool. All rights reserved.
//

#import "TransactionInfo.h"
#import "TransactionUtils.h"
#import "FCUtility.h"
#import "PrivateKey.h"
#import "TransactionBuilder.h"
#import "TransferOperation.h"

@implementation TransactionUtils {

}

+ (NSString *)initTransaction:(TransactionInfo *)transactionInfo {
    TransferOperation *transferOp = [[TransferOperation alloc] init];
    transferOp.from = transactionInfo.from;
    transferOp.to = transactionInfo.to;
    transferOp.amount = [[AssetAmount alloc] initWithAsset:transactionInfo.amountAssetId amount:transactionInfo.amountAmount];
    transferOp.fee = [[AssetAmount alloc] initWithAsset:transactionInfo.feeAssetId amount:transactionInfo.feeAmount];
    TransactionBuilder *tx = [[TransactionBuilder alloc] initWithOperations:@[transferOp]];
    tx.ref_block_num = transactionInfo.refBlockNum;
    tx.ref_block_prefix = transactionInfo.refBlockPrefix;
    tx.expiration = time(NULL) + 6 * 60 * 60;
    tx.extensions = @[];
    [tx add_signer:[PrivateKey fromWif:transactionInfo.wif]];
    NSDictionary *dictionary = [tx signedTransaction];
    NSString *jsonData = [FCUtility toJSONData:dictionary];
    NSLog(@"TransferSign======> %@", jsonData);
    return jsonData;
}

@end