//
//Created by ESJsonFormatForMac on 18/08/15.
//

#import "AccountInfo.h"
@implementation AccountInfo

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"result" : [Result class]};
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end

@implementation Result


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID":@"id"};
}

@end


@implementation Options


@end


@implementation Owner


@end


@implementation Active


@end


