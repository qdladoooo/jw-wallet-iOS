//
//Created by ESJsonFormatForMac on 18/08/15.
//获取到的资产信息在这个类里存放

#import <Foundation/Foundation.h>

@class AssetsResult,AssetsOptions,Core_Exchange_Rate,Base,Quote;
@interface AssetsInfo : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *jsonrpc;

@property (nonatomic, strong) NSArray<AssetsResult *> *result;

@end
@interface AssetsResult : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *symbol;

@property (nonatomic, assign) NSInteger precision;

@property (nonatomic, strong) AssetsOptions *options;

@property (nonatomic, copy) NSString *issuer;

@property (nonatomic, copy) NSString *dynamic_asset_data_id;

@end

@interface AssetsOptions : NSObject

@property (nonatomic, strong) NSArray *whitelist_markets;

@property (nonatomic, copy) NSString *description;

@property (nonatomic, copy) NSString *max_supply;

@property (nonatomic, strong) NSArray *extensions;

@property (nonatomic, strong) NSArray *whitelist_authorities;

@property (nonatomic, copy) NSString *max_market_fee;

@property (nonatomic, strong) NSArray *blacklist_authorities;

@property (nonatomic, strong) NSArray *blacklist_markets;

@property (nonatomic, strong) Core_Exchange_Rate *core_exchange_rate;

@property (nonatomic, assign) NSInteger issuer_permissions;

@property (nonatomic, assign) NSInteger market_fee_percent;

@property (nonatomic, assign) NSInteger flags;

@end

@interface Core_Exchange_Rate : NSObject

@property (nonatomic, strong) Base *base;

@property (nonatomic, strong) Quote *quote;

@end

@interface Base : NSObject

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, copy) NSString *asset_id;

@end

@interface Quote : NSObject

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, copy) NSString *asset_id;

@end

