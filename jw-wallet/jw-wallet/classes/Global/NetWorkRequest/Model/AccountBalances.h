//
//Created by ESJsonFormatForMac on 18/08/15.
//根据账户ID查找的余额信息存放这个类
//

#import <Foundation/Foundation.h>

@class BalancesResult;

@interface AccountBalances : NSObject

@property(nonatomic, assign) NSInteger ID;

@property(nonatomic, copy) NSString *jsonrpc;

@property(nonatomic, strong) NSArray<BalancesResult *> *result;

@end

@interface BalancesResult : NSObject

@property(nonatomic, copy) NSString *amount;

@property(nonatomic, copy) NSString *asset_id;

@end

