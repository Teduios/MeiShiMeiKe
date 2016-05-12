//
//  LEENetworkManager.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/28.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "LEENetworkManager.h"
#import "AFNetworking.h"

@implementation LEENetworkManager
+(void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",@"text/javascript",@"application/json", nil];
    [manager GET:urlStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
