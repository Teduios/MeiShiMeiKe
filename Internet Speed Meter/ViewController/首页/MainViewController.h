//
//  MainViewController.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/15.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEEMenu.h"
typedef void(^BLOCK_block)(LEEMenu * menu);
@interface MainViewController : UIViewController

@property (nonatomic,copy) BLOCK_block Block_block;
@end
