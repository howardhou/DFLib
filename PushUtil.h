//
//  PushUtil.h
//  RongziTong
//
//  Created by HouHoward on 2017/1/13.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushUtil : NSObject


/**
 初始化第三方推送， 目前只支持 Umeng Push

 @param appKey APP KEY
 @param launchOptions 启动参数
 @param delegate 代理
 */
+ (void)pushWithAppKey:(NSString *) appKey andLaunchOptions:(NSDictionary *)launchOptions andDelegate:(id)delegate;


/**
 向第三方推送注册 DeviceToken

 @param deviceToken NSData 类型
 */
+ (void)registerDeviceToken:(NSData *)deviceToken;

/**
 收到APS推送通知时调用

 @param userInfo 推送自定义的参数
 */
+ (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;


/**
 添加别名

 @param alias 别名
 @param type 别名的类型，如果传nil则被 “all”
 */
+(void)addAlias:(NSString *)alias type:(NSString *) type;


/**
 移除别名

 @param alias 别名
 @param type 别名的类型，如果传nil则被 “all”
 */
+(void)removeAlias:(NSString *) alias type:(NSString *) type;

@end
