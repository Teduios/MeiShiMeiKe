//
//  LEEDetailViewController.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/24.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEEMenu.h"

typedef void(^Block)(BOOL isLike);

@interface LEEDetailViewController : UIViewController
@property (nonatomic,strong) NSArray *steps;
@property (nonatomic,copy) Block block;
@property (nonatomic,strong) NSString *str;
@property (nonatomic,strong) LEEMenu *menu;
@end
