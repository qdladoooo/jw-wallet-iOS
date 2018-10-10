//
//Created by ESJsonFormatForMac on 18/09/21.
//

#import <Foundation/Foundation.h>

@class TRResult,Trx;
@interface TransactionResult : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *jsonrpc;

@property (nonatomic, strong) TRResult *result;

@end
@interface TRResult : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger trx_num;

@property (nonatomic, assign) NSInteger block_num;

@property (nonatomic, strong) Trx *trx;

@end

@interface Trx : NSObject

@property (nonatomic, strong) NSArray *extensions;

@property (nonatomic, assign) NSInteger ref_block_num;

@property (nonatomic, strong) NSArray<NSString *> *signatures;

@property (nonatomic, strong) NSArray *operation_results;

@property (nonatomic, assign) NSInteger ref_block_prefix;

@property (nonatomic, copy) NSString *expiration;

@property (nonatomic, strong) NSArray *operations;

@end

