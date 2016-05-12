//
//  LEEMenuSteps.h
//  Internet Speed Meter
//
//  Created by lee on 16/4/7.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEEMenuSteps : NSObject
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *step;
+(instancetype)getDataWithDict:(NSDictionary*)dict;
@end
