//
//  LEEBackgroundViewController.h
//  Internet Speed Meter
//
//  Created by lee on 16/4/25.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^Block_bg)(NSString *);

@interface LEEBackgroundViewController : UIViewController
@property (nonatomic,copy) Block_bg block_bg;

@end
