//
//  LEEMenu.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/24.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEEMenu : NSObject<NSCoding>
@property (nonatomic,strong) NSString *title;
//@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSString *tags;
/*图片*/
@property (nonatomic,strong) NSString *intro;
/*关键词 */
@property (nonatomic,strong) NSString *ingredients;
/*name */
@property (nonatomic,strong) NSString *burden;
/*message */
@property (nonatomic,strong) NSString *albums;
//步骤
@property (nonatomic,strong) NSArray *steps;
+(instancetype)getDataWithDict:(NSDictionary*)dict;
@end
