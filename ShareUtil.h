//
//  ShareUtil.h
//  RongziTong
//
//  Created by HouHoward on 2017/1/12.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SharePlateform){
    SharePlateformSina = 0,         //Sina微博
    SharePlateformWeChatSession,  //微信聊天
    SharePlateformWeChatTimeline, //朋友圈
    SharePlateformQQ    //QQ
};


@interface ShareUtil : NSObject


/**
 初始化共享，目前只支持 Umeng Share

 @param appKey Umeng App Key
 */
+ (void) shareWithAppKey:(NSString *) appKey;

/**
 设置支持的共享平台，目前只支持 Sina，微信，QQ，支持的平台，在 SharePlateform 枚举中有定义

 @param plateform 社交平台，关于微信的两个平台 SharePlateformWeChatSession 和 SharePlateformWeChatTimeline 只需要设置 SharePlateformWeChatSession 就可以了
 @param appKey 社交平台的app key, 如：sina app key
 @param appSecret 社交平台的app secret, 如：sina app secret
 */
+ (void) setPlaform: (SharePlateform) plateform appKey: (NSString *) appKey appSecret: (NSString *)appSecret;

/**
 处理打开URL

 @param url URL
 @return 是否成功
 */
+ (BOOL) handleOpenURL:(NSURL *) url;


/**
 共享到社交平台

 @param plateform 共享平台
 @param controller 控制器
 @param title 共享标题
 @param text 共享文本
 @param url 共享URL
 @param completion 共享完成
 */
+ (void)shareToPlateform:(SharePlateform) plateform controller:(UIViewController *)controller title:(NSString *) title text:(NSString *)text url:(NSString *) url completion:(void (^)(NSError *error)) completion;
@end
