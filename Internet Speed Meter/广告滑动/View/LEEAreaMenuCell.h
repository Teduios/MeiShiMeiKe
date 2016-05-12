//
//  LEEAreaMenuCell.h
//  Internet Speed Meter
//
//  Created by lee on 16/3/29.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEEAreaMenu.h"
@interface LEEAreaMenuCell : UITableViewCell
+(LEEAreaMenuCell *)cellForTableView:(UITableView *)tableView;
-(void)setData:(LEEAreaMenu *)areaMenu;
@end
