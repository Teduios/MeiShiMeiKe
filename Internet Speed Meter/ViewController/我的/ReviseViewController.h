//
//  ReviseViewController.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/17.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BLOCK_STR)(NSString*);

@interface ReviseViewController : UIViewController
/*属性*/
@property (nonatomic,copy) BLOCK_STR block_str;
/*属性*/
@property (nonatomic,copy) NSString *str;
@end
