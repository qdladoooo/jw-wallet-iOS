//
//Created by ESJsonFormatForMac on 18/08/16.
//

#import <Foundation/Foundation.h>


@interface AccountObserverFull : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *jsonrpc;

@property (nonatomic, strong) NSArray *result;

@end
