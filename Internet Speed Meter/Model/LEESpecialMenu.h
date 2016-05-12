//
//  LEESpecialMenu.h
//  Internet Speed Meter
//
//  Created by lee on 16/4/5.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEESpecialMenu : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *imageName;
+(NSArray*)SpecialMenu;
@end
