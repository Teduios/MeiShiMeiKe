//
//  EditTableViewController.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/17.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BLOCK_BACK)(UIImage*,NSString*,NSString *);

@interface EditTableViewController : UITableViewController
@property (nonatomic,copy) BLOCK_BACK  block_back;
@end
