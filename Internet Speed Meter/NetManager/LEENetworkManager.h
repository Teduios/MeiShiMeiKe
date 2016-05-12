//
//  LEENetworkManager.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/28.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEENetworkManager : NSObject
//block分类(四类)：没有传参/没有返回值;有传参/没有返回值...
//方式二
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);

////方式一(block使用copy)
//@property (nonatomic, copy) void(^successBlock)(id responseObject);
+ (void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;
//声明post方法
//声明put/delete方法
@end
