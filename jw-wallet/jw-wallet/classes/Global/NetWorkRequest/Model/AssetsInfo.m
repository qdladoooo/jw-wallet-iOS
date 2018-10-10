//
//Created by ESJsonFormatForMac on 18/08/15.
//

#import "AssetsInfo.h"

@implementation AssetsInfo
+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
            @"result": [AssetsResult class]
    };
}


+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"ID": @"id"};
}

@end

@implementation AssetsResult

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
            @"options": [AssetsOptions class],
    };
}


+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"ID": @"id"};
}

@end


@implementation AssetsOptions


@end


@implementation Core_Exchange_Rate


@end


@implementation Base


@end


@implementation Quote


@end


