//
//  LEEDataManager.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/28.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEEMenu.h"
#import "LEEAllTypeMenu.h"
@interface LEEDataManager : NSObject
+(NSArray*)getAllMenuData:(id)responseObject;
+(NSArray*)getALlMEnuSteps:(LEEMenu*)menu;

@end
