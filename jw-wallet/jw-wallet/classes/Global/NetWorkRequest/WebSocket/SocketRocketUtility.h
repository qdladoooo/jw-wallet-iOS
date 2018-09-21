//
//  SocketRocketUtility.h
//  SUN
//
//  Created by 孙俊 on 17/2/16.
//  Copyright © 2017年 SUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>

extern NSString *const kNeedPayOrderNote;
extern NSString *const kWebSocketDidOpenNote;
extern NSString *const kWebSocketDidCloseNote;
extern NSString *const kWebSocketdidReceiveMessageNote;

@interface SocketRocketUtility : NSObject

typedef void (^SocketDidOpen)(void);

typedef void (^SocketDidClose)(void);

typedef void (^SocketDidReceiveMessage)(id message);

// 获取连接状态
@property(nonatomic, assign, readonly) SRReadyState socketReadyState;
@property(nonatomic, strong) SocketDidOpen didOpen;
@property(nonatomic, strong) SocketDidClose didClose;
@property(nonatomic, strong) SocketDidReceiveMessage didReceiveMessage;

+ (SocketRocketUtility *)instance;

- (void)SRWebSocketOpenWithURLString:(NSString *)urlString;//开启连接
- (void)SRWebSocketClose;//关闭连接
- (void)sendData:(id)data;//发送数据
//- (void)sendData:(id)data withMethod:(NSString *)method IDStr:(NSString *)IDStr;
- (void)sendDataWithJson:(NSString *)jsonString;

@end
