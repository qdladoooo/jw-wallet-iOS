//
//Created by ESJsonFormatForMac on 18/09/18.
//

#import <Foundation/Foundation.h>

@class ChainPropertiesResult,Immutable_Parameters;
@interface ChainProperties : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *jsonrpc;

@property (nonatomic, strong) ChainPropertiesResult *result;

@end
@interface ChainPropertiesResult : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *chain_id;

@property (nonatomic, strong) Immutable_Parameters *immutable_parameters;

@end

@interface Immutable_Parameters : NSObject

@property (nonatomic, assign) NSInteger min_witness_count;

@property (nonatomic, assign) NSInteger num_special_assets;

@property (nonatomic, assign) NSInteger num_special_accounts;

@property (nonatomic, assign) NSInteger min_committee_member_count;

@end

