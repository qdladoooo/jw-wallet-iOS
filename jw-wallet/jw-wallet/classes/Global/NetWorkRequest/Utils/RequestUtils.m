 //
// Created by Cool on 2018/8/15.
// Copyright (c) 2018 Cool. All rights reserved.
//

#import "RequestUtils.h"

@interface RequestUtils ()

@end

@implementation RequestUtils {

}

+ (NSString *)lookup_account_names:(NSString *)names {
    return [self lookup_account_names:LOOKUP_ACCOUNT_NAMES_ID names:names];
}

+ (NSString *)lookup_account_names:(int)id names:(NSString *)names {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,", id];
    [json appendFormat:@"\"method\":\"call\", "];
    [json appendFormat:@"\"params\":[0,\"lookup_account_names\",[[\"%@\"]]]}", names];
    return json;
}

+ (NSString *)get_account_balances:(NSString *)ids {
    return [self get_account_balances:GET_ACCOUNT_BALANCES_ID ids:ids];
}

+ (NSString *)get_account_balances:(int)id1 ids:(NSString *)ids {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,", id1];
    [json appendFormat:@"\"method\":\"call\", "];
    [json appendFormat:@"\"params\":[0,\"get_account_balances\",[\"%@\", []]]}", ids];
    return json;
}

+ (NSString *)get_assets:(NSString *)ids {
    return [self get_assets:GET_ASSETS_ID ids:ids];
}

+ (NSString *)get_assets:(int)id1 ids:(NSString *)ids {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,", id1];
    [json appendFormat:@"\"method\":\"call\", "];
    [json appendFormat:@"\"params\":[0,\"get_assets\",[[\"%@\"]]]}", ids];
    return json;
}

+ (NSString *)get_accounts:(NSString *)ids {
    return [self get_accounts:GET_ACCOUNTS_ID ids:ids];
}

+ (NSString *)get_accounts:(int)id1 ids:(NSString *)ids {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,", id1];
    [json appendFormat:@"\"method\":\"call\", "];
    [json appendFormat:@"\"params\":[0,\"get_accounts\",[[\"%@\"]]]}", ids];
    return json;
}

+ (NSString *)login {
    return [self login:LOGIN_ID];
}

+ (NSString *)login:(int)id {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,\"method\": \"call\", \"params\": [1, \"login\", [\"\", \"\"]], \"jsonrpc\": \"2.0\"}", id];
    return json;
}

+ (NSString *)database {
    return [self database:DATABASE_ID];
}

+ (NSString *)database:(int)id {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,\"method\": \"call\", \"params\": [1, \"database\", []], \"jsonrpc\": \"2.0\"}", id];
    return json;
}

+ (NSString *)set_subscribe_callback {
    return [self set_subscribe_callback:SET_SUBSCRIBE_CALLBACK_ID];
}

+ (NSString *)set_subscribe_callback:(int)id1 {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,\"method\": \"call\", \"params\": [0, \"set_subscribe_callback\", [1, false]], \"jsonrpc\": \"2.0\"}", id1];
    return json;
}

+ (NSString *)cancel_all_subscriptions {
    return [self cancel_all_subscriptions:CANCEL_ALL_SUBSCRIPTIONS_ID];
}

+ (NSString *)cancel_all_subscriptions:(int)id1 {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,\"method\": \"call\", \"params\": [0, \"cancel_all_subscriptions\", []], \"jsonrpc\": \"2.0\"}", id1];
    return json;
}

+ (NSString *)get_full_accounts:(NSString *)ids {
    return [self get_full_accounts:GET_FULL_ACCOUNTS_ID ids:ids];
}

+ (NSString *)get_full_accounts:(int)id1 ids:(NSString *)ids {
    NSMutableString *json = [[NSMutableString alloc] init];
    [json appendFormat:@"{\"id\":%d,\"method\": \"call\", \"params\": [0, \"get_full_accounts\", [[\"%@\"], true]], \"jsonrpc\": \"2.0\"}", id1, ids];
    return json;
}


@end
