//
//  ShareUtil.m
//  RongziTong
//
//  Created by HouHoward on 2017/1/12.
//  Copyright © 2017年 rongzi. All rights reserved.
//

#import "ShareUtil.h"

#import <UMSocialCore/UMSocialCore.h>

@implementation ShareUtil

+ (void) shareWithAppKey:(NSString *) appKey{

    #ifdef DEBUG
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    #endif
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey: appKey];
}

+ (void)setPlaform:(SharePlateform)plateform appKey:(NSString *)appKey appSecret:(NSString *)appSecret{
    switch (plateform) {
        case SharePlateformSina:
            //设置新浪的appKey和appSecret
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey: appKey appSecret: appSecret redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
            break;
            
        case SharePlateformWeChatSession:
        case SharePlateformWeChatTimeline:
            //设置微信的appKey和appSecret
            [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey: appKey appSecret: appSecret redirectURL:@"http://mobile.umeng.com/social"];
          
        case SharePlateformQQ:
            
            break;
        default:
            break;
    }
}


+(BOOL)handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

+(void)shareToPlateform:(SharePlateform) plateform controller:(UIViewController *)controller title:(NSString *) title text:(NSString *)text url:(NSString *) url completion:(void (^)(NSError *error)) completion{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage* thumbURL = [UIImage imageNamed:@"sharelogo"]; //@"sharelogo.png";
    
    UMSocialPlatformType type;
    
    switch (plateform) {
        case SharePlateformSina:
            messageObject.title = title;
            messageObject.text = [NSString stringWithFormat:@"[%@]%@%@", title, text, url];
            type = UMSocialPlatformType_Sina;
            
            break;
        case SharePlateformWeChatSession:{
            type = UMSocialPlatformType_WechatSession;
            
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: title descr: text thumImage:thumbURL];
            //设置网页地址
            shareObject.webpageUrl = url;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            break;
        }
        case SharePlateformWeChatTimeline:{
            
            type = UMSocialPlatformType_WechatTimeLine;
            
            title = [NSString stringWithFormat:@"[%@]%@", title, text];
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle: title descr: text thumImage:thumbURL];
            //设置网页地址
            shareObject.webpageUrl = url;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            break;
        }
        default:
            break;
    }
    
    [[UMSocialManager defaultManager] shareToPlatform: type messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        
        if (completion) {
            completion(error);
        }
    }];
}
@end
