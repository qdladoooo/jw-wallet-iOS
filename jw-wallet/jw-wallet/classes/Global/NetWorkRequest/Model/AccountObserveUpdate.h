//
//Created by ESJsonFormatForMac on 18/08/16.
//监控账户更新返回的结果类
//{"id":1,"jsonrpc":"2.0","result":true}
//{"id":2,"jsonrpc":"2.0","result":2}
//{"id":3,"jsonrpc":"2.0","result":null}

#import <Foundation/Foundation.h>


@interface AccountObserveUpdate : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *jsonrpc;

@property (nonatomic, copy) NSString *result;

@end
