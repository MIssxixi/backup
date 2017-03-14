//
//  AppDelegate.m
//  AliHotFixDemo
//
//  Created by jiangpan on 16/10/11.
//  Copyright © 2016年 jiangpan. All rights reserved.
//

#import "AppDelegate.h"
#import <AliHotFix/AliHotFix.h>
#import <AliHotFixDebug/AliHotFixDebug.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
      char aesEncryptKeyBytes[] = {xxxxx}
      NSData *aesEncryptKeyData = [NSData dataWithBytes:aesEncryptKeyBytes length:sizeof(aesEncryptKeyBytes)];
     
      char rsaPublicDerBytes[]= {xxxxx}
      NSData *rsaPublicDerData = [NSData dataWithBytes:rsaPublicDerBytes length:sizeof(rsaPublicDerBytes)];
    
      代码生成步骤见:百川开放平台HotFix接入
     */
    
    //加解密补丁文件的密钥(该密钥已加密)
    char aesEncryptKeyBytes[] = {-106,0,-127,-95,-109,-44,-87,84,110,6,-108,-74,-58,-115,37,1,-52,-96,-102,70,-112,73,126,113,-82,120,-72,75,31,-87,-126,75};
    NSData *aesEncryptKeyData = [NSData dataWithBytes:aesEncryptKeyBytes length:sizeof(aesEncryptKeyBytes)];
    //本地自签名证书RSA公钥
    char rsaPublicDerBytes[]={48,-126,2,1,48,-126,1,106,2,9,0,-79,22,-42,-112,86,-37,19,-31,48,13,6,9,42,-122,72,-122,-9,13,1,1,5,5,0,48,69,49,11,48,9,6,3,85,4,6,19,2,65,85,49,19,48,17,6,3,85,4,8,19,10,83,111,109,101,45,83,116,97,116,101,49,33,48,31,6,3,85,4,10,19,24,73,110,116,101,114,110,101,116,32,87,105,100,103,105,116,115,32,80,116,121,32,76,116,100,48,30,23,13,49,54,49,48,51,49,48,56,51,53,48,51,90,23,13,50,54,49,48,50,57,48,56,51,53,48,51,90,48,69,49,11,48,9,6,3,85,4,6,19,2,65,85,49,19,48,17,6,3,85,4,8,19,10,83,111,109,101,45,83,116,97,116,101,49,33,48,31,6,3,85,4,10,19,24,73,110,116,101,114,110,101,116,32,87,105,100,103,105,116,115,32,80,116,121,32,76,116,100,48,-127,-97,48,13,6,9,42,-122,72,-122,-9,13,1,1,1,5,0,3,-127,-115,0,48,-127,-119,2,-127,-127,0,-42,18,-126,-97,-3,105,-91,72,24,-128,-121,-53,-39,-111,-65,-128,114,101,109,52,-26,-65,-18,-42,-88,13,77,-86,-118,77,-12,42,5,-14,-100,43,-104,-74,-84,39,-51,-81,-48,16,-28,25,-66,66,29,60,-17,-115,-62,30,-19,-120,-127,72,115,59,126,-83,90,87,119,-125,24,75,-65,-85,-118,-59,89,37,51,-121,4,-95,88,-77,-108,-7,5,-32,115,61,-119,14,44,-90,-40,98,-123,96,-53,-38,-101,-128,-72,78,3,-122,-14,-40,-107,-77,-45,12,81,-78,99,-86,-3,22,-97,95,-54,-24,-96,0,14,-2,-57,-25,-2,-81,51,79,2,3,1,0,1,48,13,6,9,42,-122,72,-122,-9,13,1,1,5,5,0,3,-127,-127,0,-64,-63,-100,-76,-35,115,73,-28,40,-63,126,39,-91,109,48,47,19,113,11,60,85,24,75,123,-81,-41,90,37,-59,-82,-3,115,122,-95,-98,-84,-60,8,-12,36,124,-25,14,105,-108,-108,96,-44,-40,-126,-118,7,57,114,-53,-125,5,-125,111,53,-38,-57,80,-19,14,126,-76,-42,64,-31,52,-21,-121,-100,-109,-53,42,-9,-92,18,-94,-19,-49,55,62,-106,127,23,-23,68,-67,26,-1,39,-29,78,-63,-14,118,-11,-94,61,-67,62,-89,-107,-54,-24,31,86,-47,-63,-28,59,-116,62,48,-112,47,101,-3,114,-13,79,13,4,79,11};
    NSData *rsaPublicDerData = [NSData dataWithBytes:rsaPublicDerBytes length:sizeof(rsaPublicDerBytes)];

    NSString * secret = @"30bbfc7a5e8625c570f46ef57511fe42";
    NSString * privateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDq6ozsVvKAy27NLQiu9QukdfE1zAIZkul4vjWRwZyCdSCE9nD80CjWkTqrwJfv63Cpc1vIXJnu8542zguDq7lLUoQNNKTcbb77iBZKGTUeby3h7SIQlcTP/1L6ucpG8c4KjF2JzvRNiu+iAFSTGoDksiUnp8txj8NBURIMO878FVUVFxYWDyJxth//TJX71BppDhW1/628RP2JXe/abRBkeSJvNwDEJXIv82iAk3TAfDuKUYQlx/73imkGt7dB+IQoRbMbgYLB8ly24EtAbB7EboNKB9XeIyQ1QN5IPUAs3cq6cTlt3NuCF+vL5i571hH3UxST/gE2Z/WIu/CVSaL7AgMBAAECggEAeAE/4k/8a+0AelHiGLZXrzkM8sV34SaanDLW3NHCKSa6aRIX4B5ablocVbb6JvboQ7gJkA42GMpc7XROj4H/E0pg6PoWqgBqSsZXVJ0R9K0pDDv+ZeiMdRDii/CzM5C9B8hy1D5jsOUjy2dNzSQB6lJTBrICDM47GbfXd2ZqM32bk7s0MlexS+iMcg0xGgA0YBYksX2FzIiAn/tm+PbWoB4gkPixmQIhhm8+Ck7SPL3zTs362WgxvyVltqV4rheR3Yzhgs4836s8aCVAAluniG9gg2po+Nbe6/Gii2I//TZ5BjnLoXiNMwHjercwe4ChGFkVG5I+vjWXawwX6Pa32QKBgQD+YU/MaShTVFq4JwMwXEaV8BWNHphQCe1FKAYi3VJvvaI2YmNlT+8tjJCSQ86PiqHBNCFoRH+O0PcfpSbhNYlA63HQU7iEGPYkZ/YVwXZNrujQogXMTiJcQC8xX/XLAkHctbSUVslrbjHob24rr+6jr42kYjyklWKR2RV9ADKMNwKBgQDsaYJFMLjPWN0sUbuHWdI9+fju0FLDjm6XB6AZe3kQ5XGrHVNwQMaGRa3QzdlMx29wy6ztP4jQQgxk8lwt42LGrnU2iS1EUjnrbynEJV4lxuaYhZddUkAcpvxKtbLUAtnZmMaxj0diMeU202QZAx6BKududhMpn2+G3u7J271lXQKBgQDyC3gZoUmsmIxFw2FGZ9cGHk7zW1REfF2XOzEzhXJGPqOVqeK36OpFZgW+FuT6MkgdhVPwWZUiOHWcV9H54q355s4CE1dz4ih7laxTISVHX5HJyxFHSGVrb+s3yP4gr8Ipl3/+0eGP5md4qmajDSE+APH+ozbeyAHlkzDeIwz12wKBgHC9O/9s5aUTtp2M+IXqYqVlkL2qIN3bDYf+fe3JAQn6sQMt//1XFpUvo10g3VCNBureZj/ZfY/6/1ggb67+cbtXtNPmBO1A3RgWMe+09jnDqXHwuycosyQ2ybeDAJ20IllvTsmcDymXq7xCgMigwSpN4IG/0xGVU6UYqP0gSiiNAoGBAMq02RWXfqteQkCAn87IWGjFl6b6BBRoluZhJiqmpwqlRff2eHB+Fj+Vw2Zz+KZdxuq+IwQNko1K8/wSSwNCS0ORA+dxoJt/YZYCqbSstkWjN85mfciCNS0fFGWc8ywMReamCoERqKiVqHjzYypf80ytZBZMPi3qYNm47hyLu2kA";

    // 百川平台申请的appid,secret,rsaKey.以及本地打包自签证书的RSA公钥&本地加密patch密钥
//    [AliHotFix startWithAppID:@"71044-2" secret:secret privateKey:privateKey publicKey:rsaPublicDerData encryptAESKey:aesEncryptKeyData];
    [AliHotFixDebug runPatch:@"/Users/bjhl/ios/testPatch/patch"];
    

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
