//
//Created by ESJsonFormatForMac on 18/08/15.
//获取到的账号信息存放在这个类里
//

#import <Foundation/Foundation.h>

@class Result,Options,Owner,Active;
@interface AccountInfo : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *jsonrpc;

@property (nonatomic, strong) NSArray<Result *> *result;

@end
@interface Result : NSObject

@property (nonatomic, strong) Active *active;

@property (nonatomic, copy) NSString *lifetime_referrer;

@property (nonatomic, strong) Options *options;

@property (nonatomic, strong) Owner *owner;

@property (nonatomic, assign) NSInteger referrer_rewards_percentage;

@property (nonatomic, assign) NSInteger network_fee_percentage;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray *whitelisted_accounts;

@property (nonatomic, copy) NSString *membership_expiration_date;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *registrar;

@property (nonatomic, copy) NSString *referrer;

@property (nonatomic, copy) NSString *cashback_vb;

@property (nonatomic, strong) NSArray *whitelisting_accounts;

@property (nonatomic, strong) NSArray *blacklisted_accounts;

@property (nonatomic, copy) NSString *statistics;

@property (nonatomic, strong) NSArray<NSNumber *> *owner_special_authority;

@property (nonatomic, strong) NSArray *blacklisting_accounts;

@property (nonatomic, assign) NSInteger top_n_control_flags;

@property (nonatomic, strong) NSArray<NSNumber *> *active_special_authority;

@property (nonatomic, assign) NSInteger lifetime_referrer_fee_percentage;

@end

@interface Options : NSObject

@property (nonatomic, assign) NSInteger num_committee;

@property (nonatomic, strong) NSArray *votes;

@property (nonatomic, strong) NSArray *extensions;

@property (nonatomic, copy) NSString *voting_account;

@property (nonatomic, copy) NSString *memo_key;

@property (nonatomic, assign) NSInteger num_witness;

@end

@interface Owner : NSObject

@property (nonatomic, assign) NSInteger weight_threshold;

@property (nonatomic, strong) NSArray *account_auths;

@property (nonatomic, strong) NSArray *key_auths;

@property (nonatomic, strong) NSArray *address_auths;

@end

@interface Active : NSObject

@property (nonatomic, assign) NSInteger weight_threshold;

@property (nonatomic, strong) NSArray *account_auths;

@property (nonatomic, strong) NSArray *key_auths;

@property (nonatomic, strong) NSArray *address_auths;

@end

