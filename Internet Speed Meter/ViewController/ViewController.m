//
//  ViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/10.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH self.view.bounds.size.width
#define SCREEN_HEIGHT self.view.bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScrollView];
    [self setUpPageControl];
    
}
-(void)setUpScrollView{
    self.scrollView.contentSize=CGSizeMake(SCREEN_WIDTH*4, SCREEN_HEIGHT);
    [self.view addSubview:self.scrollView];
    for (int i=0; i<4; i++) {
        NSString *imageName=[NSString stringWithFormat:@"2%d",i+1];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView.image=[UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        if (i==3) {
            [self configEnterButton:imageView];
        }
    }
    self.scrollView.pagingEnabled=YES;
    self.scrollView.bounces=NO;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.delegate=self;
    
}
-(void)configEnterButton:(UIImageView*)imageView{
    imageView.userInteractionEnabled=YES;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, SCREEN_HEIGHT-100, 80, 40)];
    [imageView addSubview:button];
    [button setTitle:@"welcome" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterApp) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)enterApp{
    [UIApplication sharedApplication].keyWindow.rootViewController=[self.storyboard instantiateInitialViewController];
}

-(void)setUpPageControl{
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    self.pageControl.numberOfPages=4;
    self.pageControl.frame=CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 30);
    self.pageControl.userInteractionEnabled=NO;
    [self.view addSubview:self.pageControl];
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index=round(self.scrollView.contentOffset.x/SCREEN_WIDTH);
    self.pageControl.currentPage=index;
}
@end
