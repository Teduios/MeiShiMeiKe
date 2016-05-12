//
//  AdView.m
//  音乐播放器滚动界面
//
//  Created by zx on 16/2/28.
//  Copyright © 2016年 zx. All rights reserved.
//

#import "AdView.h"
#import "AdImageView.h"

typedef enum {
    RIGHT,
    LEFT
}NEXT_TYPE;

@interface AdView () <UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)AdImageView *leftImageView;
@property(nonatomic,strong)AdImageView *centerImageView;
@property(nonatomic,strong)AdImageView *rightImageView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSArray *allImages;
//@property(nonatomic,strong)NSArray *allItles;
@property(nonatomic,assign)NSInteger imageCount;
@property(nonatomic,assign)NSInteger currentImageIndex;
@end

@implementation AdView

-(id)initWithFrame:(CGRect)frame Images:(NSArray *)images Titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
 
        self.allImages = images;
        //        self.allItles = titles;
        self.imageCount = self.allImages.count;
        self.currentImageIndex = 0;
        
        [self setupScrollview];
        [self setupImageViews];
        [self setupPageControl];
        [self setupDefaultImage];
    }
    return self;
}

-(void)setupScrollview {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    //设置代理
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    //设置当前显示的位置在中间图片
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    //设置分页
    self.scrollView.pagingEnabled = YES;
    //去掉水平滚动
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //边缘不弹跳
    self.scrollView.bounces = NO;
}

-(void)setupImageViews {
    self.leftImageView = [[AdImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:self.leftImageView];
    
    self.centerImageView = [[AdImageView alloc]initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    
    __weak id safeSelf = self;
    //给图片添加点钟事件
    [self.centerImageView addTapListenter:^() {
        //点中事件的方法
        [safeSelf tapImage];
    }];
    [self.scrollView addSubview:_centerImageView];
    
    
    self.rightImageView = [[AdImageView alloc]initWithFrame:CGRectMake(2*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    [self.scrollView addSubview:_rightImageView];
}

-(void)setupPageControl {
    self.pageControl = [[UIPageControl alloc]init];
    CGSize size = [self.pageControl sizeForNumberOfPages:self.imageCount];
    self.pageControl.frame = CGRectMake(0, 0, size.width, size.height);
    self.pageControl.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 20);
    
    //设置颜色
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //设置总页数
    self.pageControl.numberOfPages = self.imageCount;
    [self addSubview:_pageControl];
}

-(void)setupDefaultImage
{
    self.leftImageView.image =[UIImage imageNamed: self.allImages[self.imageCount-1]];
    self.centerImageView.image =[UIImage imageNamed: self.allImages[0]];
    self.rightImageView.image =[UIImage imageNamed: self.allImages[1]];
    // 记录当前页
    self.currentImageIndex = 0;
    self.pageControl.currentPage = self.currentImageIndex;
}

//点中图片
-(void)tapImage {
    if (self.delegate != nil) {
        [self.delegate AdView:self didSelectorAtIndex:self.currentImageIndex];
    }
}


//滚动已经停止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //根据滑动处理左右图片
    [self reloadImage];
    //位置移动回到中间
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    NSLog(@"currentImageIndex %ld", _currentImageIndex);
    //修改分页控制上的小圆点
    self.pageControl.currentPage = self.currentImageIndex;
}


-(void)reloadImage {
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x > self.bounds.size.width) {//向右滑动
        self.currentImageIndex = [self computeNextIndex:self.currentImageIndex nextType:RIGHT];
    }else if(offset.x < self.bounds.size.width) { //向左滑动
        self.currentImageIndex = [self computeNextIndex:self.currentImageIndex nextType:LEFT];
    }
    self.centerImageView.image = [UIImage imageNamed:self.allImages[self.currentImageIndex]];
    self.rightImageView.image = [UIImage imageNamed:self.allImages[[self computeNextIndex:self.currentImageIndex nextType:RIGHT]]];
    self.leftImageView.image = [UIImage imageNamed:self.allImages[[self computeNextIndex:self.currentImageIndex nextType:LEFT]]];
}

-(NSInteger)computeNextIndex:(NSInteger)currentIndex nextType:(NEXT_TYPE)type {
    switch (type) {
        case RIGHT:
            return ++currentIndex > self.imageCount - 1 ? 0 : currentIndex;
        case LEFT:
            return --currentIndex < 0 ? self.imageCount - 1 : currentIndex;
    }
}




@end