//
//  SSHelpWordsModel.h
//  jw-wallet
//
//  Created by 王冠阳 on 2018/6/14.
//  Copyright © 2018年 SHSF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSHelpWordsModel : NSObject
//result =     {
//    "brain_priv_key" = "DROLLY MOIT SEINER PERFUME PILOSE BUGLOSS LANUM PITHOLE PITARAH PAPANE BORH ELUSORY COVADO COMEDY ACHER PROWL";
//    "pub_key" = KRIS7ChGFnNLHKMdcbuFzqDmTqWFgrHzXk9r9wKjwBqoGg2QVi4SZH;
//    "wif_priv_key" = 5JQhUYThdZz82BTY9aLrE7tN3eqGtXicBv9YCuNCCjNVXbkfzju;
//};
//"result_code" = 10000;
//}
@property (nonatomic, copy) NSString *result_code;
@property (nonatomic, copy) NSString *brain_priv_key;
@property (nonatomic, copy) NSString *pub_key;
@property (nonatomic, copy) NSString *wif_priv_key;

@end
