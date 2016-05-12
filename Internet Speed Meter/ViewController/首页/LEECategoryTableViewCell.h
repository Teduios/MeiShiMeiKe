//
//  LEECategoryTableViewCell.h
//  Internet Speed Meter
//
//  Created by lee on 16/4/6.
//  Copyright © 2016年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LEECategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabels;

@end
