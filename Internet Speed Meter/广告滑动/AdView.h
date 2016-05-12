//
//  AdView.h
//  音乐播放器滚动界面
//
//  Created by zx on 16/2/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdView;

@protocol AdViewDelegate <NSObject>
@required
-(void)AdView:(AdView*)adview didSelectorAtIndex:(NSInteger)index;
@end

@interface AdView : UIView
@property(nonatomic,weak)id<AdViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame Images:(NSArray*)images Titles:(NSArray*)titles;
@end








