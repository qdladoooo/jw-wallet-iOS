//
//Created by ESJsonFormatForMac on 18/08/15.
//

#import "AccountBalances.h"
@implementation AccountBalances

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"result" : [BalancesResult class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end

@implementation BalancesResult


@end


