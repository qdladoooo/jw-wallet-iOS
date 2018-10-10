//
//Created by ESJsonFormatForMac on 18/09/17.
//

#import <Foundation/Foundation.h>

@class PropertiesResult;
@interface GlobalProperties : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *jsonrpc;

@property (nonatomic, strong) PropertiesResult *result;

@end
@interface PropertiesResult : NSObject

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *head_block_id;

@property (nonatomic, assign) NSInteger current_aslot;

@property (nonatomic, assign) NSInteger dynamic_flags;

@property (nonatomic, assign) NSInteger last_irreversible_block_num;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) NSInteger recently_missed_count;

@property (nonatomic, copy) NSString *next_maintenance_time;

@property (nonatomic, assign) NSInteger head_block_number;

@property (nonatomic, assign) NSInteger witness_budget;

@property (nonatomic, copy) NSString *current_witness;

@property (nonatomic, copy) NSString *last_budget_time;

@property (nonatomic, assign) NSInteger accounts_registered_this_interval;

@property (nonatomic, copy) NSString *recent_slots_filled;

@end

