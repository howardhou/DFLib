//
//  PushUtil.m
//  RongziTong
//
//  Created by HouHoward on 2017/1/13.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import "PushUtil.h"
#import "UMessage.h"

@implementation PushUtil

+ (void)pushWithAppKey:(NSString *) appKey andLaunchOptions:(NSDictionary *)launchOptions andDelegate:(id)delegate{
    
    //消息推送功能
    [UMessage startWithAppkey:appKey launchOptions:launchOptions httpsenable:YES];
    
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue] >=10) {

        //iOS10必须加下面这段代码。
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate= delegate;
        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                //这里可以添加一些自己的逻辑
            } else {
                //点击不允许
                //这里可以添加一些自己的逻辑
            }
        }];
        
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_ios10_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_ios10_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category101" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories_ios10 = [NSSet setWithObjects:category1_ios10, nil];
        [center setNotificationCategories:categories_ios10];
    }
    else{
        //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";//这组动作的唯一标示
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        
        [UMessage registerForRemoteNotifications:categories];
    }
    
#ifdef DEBUG
    //Log消息推送功能
    [UMessage setLogEnabled:YES];
#endif
    
    //#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    //    if( iOS8){
    //        //register remoteNotification types
    //        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    //        action1.identifier = @"action1_identifier";
    //        action1.title=@"Accept";
    //        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    //
    //        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    //        action2.identifier = @"action2_identifier";
    //        action2.title=@"Reject";
    //        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    //        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    //        action2.destructive = YES;
    //
    //        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    //        categorys.identifier = @"category1";//这组动作的唯一标示
    //        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
    
    //        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObject:categorys]];
    //
    //        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
    
    //    }
    //    else{
    //        //register remoteNotification types
    //        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert];
    //    }
    //#else
    //    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert];
    //#endif
}

+(void)registerDeviceToken:(NSData *)deviceToken{
    
    [UMessage registerDeviceToken:deviceToken];
}

+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    [UMessage setAutoAlert:YES];
    [UMessage didReceiveRemoteNotification:userInfo];
}

+(void)addAlias:(NSString *)alias type:(NSString *) type{
    if (!type || type.length == 0) {
        type = @"all";
    }
    [UMessage addAlias: alias type: type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
        
    }];
}

+(void)removeAlias:(NSString *) alias type:(NSString *) type{
    if (!type || type.length == 0) {
        type = @"all";
    }
    [UMessage removeAlias: alias type: type response:^(id responseObject, NSError *error) {
        
    }];
}

@end
