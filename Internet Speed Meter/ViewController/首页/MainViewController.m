//
//  MainViewController.m
//  Internet Speed Meter
//
//  Created by lee on 16/3/15.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "MainViewController.h"
#import "RESideMenu.h"
#import "AdView.h"
#import "LEEMenuTableViewCell.h"
#import "LEEDetailViewController.h"
#import "LEEMenu.h"
#import "LEEAllTypeMenu.h"
#import "LEENetworkManager.h"
#import "LEEDataManager.h"
#import "UIImageView+WebCache.h"
#import "LEESpecialMenu.h"
#import "LEECategoryTableViewController.h"
#import "LEEMenuSteps.h"
#import "LEECollectTableViewController.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD.h"

#define SCREENWIDTH self.view.bounds.size.width
#define SCREENHEIGHT self.view.bounds.size.height
#define kItemIconTag 100
#define kItemLabelTag 200

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (nonatomic,strong) NSArray *allMenus;
@property (nonatomic,strong) NSString *menuName;
@property (nonatomic,strong) NSArray *specialMenus;
@property (nonatomic,strong) NSArray *allTypeMenus;
@property (nonatomic,strong) NSString *typeName;
//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CGFloat lineSpace;

@property (nonatomic) NSInteger pg;
@property (nonatomic) NSInteger rn;
@property (nonatomic,strong) NSMutableArray *mutableArray;
@property (nonatomic,strong) UISearchBar *bar;
//@property (weak, nonatomic) IBOutlet UITextField *search;
@property (weak, nonatomic) IBOutlet UISearchBar *searchText;

@end

@implementation MainViewController
#pragma mark - lazyLoad
-(CGFloat)lineSpace{
    return (SCREENWIDTH-4*70)/4;
}
-(NSArray *)specialMenus{
    if (!_specialMenus) {
        _specialMenus=[LEESpecialMenu SpecialMenu];
    }
    return _specialMenus;
}
-(NSMutableArray *)mutableArray{
    if (!_mutableArray) {
        _mutableArray=[NSMutableArray array];
    }
    return _mutableArray;
    
}
-(NSArray *)allTypeMenus{
    if (!_allTypeMenus) {
        _allTypeMenus =[LEEAllTypeMenu AllTypeMenu];
    }
    return _allTypeMenus;
}

#pragma mark --搜索

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchText resignFirstResponder];
    self.menuName=searchBar.text;
    [self sendResquestToServer];
    NSLog(@"%@",self.menuName);
    [self.tableView1 setContentOffset:CGPointMake(0, 0) animated:YES];
}
#pragma mark -启动
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pg=0;
    self.rn=0;
    int i= arc4random()%(self.allTypeMenus.count);
    LEEAllTypeMenu *typeName =self.allTypeMenus[i];
    self.typeName=typeName.type;
    NSLog(@"%@",self.typeName);
//    UIImageView *leftImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Search2"]];
//    leftImageView.frame=CGRectMake(5, 2, 24, 24);
//    self.search.leftViewMode=UITextFieldViewModeAlways;
//    self.search.leftView=leftImageView;
    [self sendResquestToServer];
    
    [self listenNotification];
    
    //添加下拉刷新
    [self.tableView1 addHeaderRefresh:^{
        self.pg++;
        [self.tableView1 endHeaderRefresh];
        [self sendResquestToServer];
    }];
    [self.tableView1 beginHeaderRefresh];
    // self.tableView1.userInteractionEnabled=YES;
    [self.tableView1 addBackFooterRefresh:^{
        
        self.rn+=10;
        [self.tableView1 endFooterRefresh];
        [self sendResquestToServer];
    }];
    [self.tableView1 beginFooterRefresh];
    
}

#pragma mark -观察者模式
-(void)listenNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(listenChangeMenu:) name:@"DidMenuChange" object:nil];
}
-(void)listenChangeMenu:(NSNotification*)notification{
    self.menuName=notification.userInfo[@"MenuName"];
    
    [self sendResquestToServer];
    [self.tableView1 setContentOffset:CGPointMake(0, 0) animated:YES];
}



#pragma mark - UICollectionView Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.specialMenus.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    LEESpecialMenu *menu=self.specialMenus[indexPath.row];
    UIImageView *iconIv=(UIImageView*)[cell.contentView viewWithTag:100];
    iconIv.layer.cornerRadius=10;
    iconIv.clipsToBounds=YES;
    UILabel *titleLb=(UILabel*)[cell viewWithTag:200];
    iconIv.image=[UIImage imageNamed:menu.imageName];
    titleLb.text=menu.title;
    collectionView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.lineSpace;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, self.lineSpace, 5, self.lineSpace);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LEECategoryTableViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryView"];
    LEESpecialMenu *menu1=self.specialMenus[indexPath.row];
    
    vc.titleName=[menu1.title substringWithRange:NSMakeRange(0, 2)];
    [self.navigationController pushViewController:vc animated:YES];
    //[self sendResquestToServer];
}


#pragma mark -UITableViewControllerDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView1{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView1 numberOfRowsInSection:(NSInteger)section{
    return self.allMenus.count+2;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    tableView1.backgroundColor=[UIColor clearColor];
    
    if (indexPath.row==0) {
        
        
            cell=[tableView1 dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            AdView *adview=[[AdView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 140) Images:@[@"tiane",@"lqbz",@"ou",@"bei",@"rou"] Titles:nil];
            [cell.contentView addSubview:adview];
            return cell;
        
    }else if (indexPath.row==1){
        cell=[tableView1 dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        //tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;
    }else{
            cell=[tableView1 dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            
            LEEMenu *menu=self.allMenus[indexPath.row-2];
            NSURL *url=[NSURL URLWithString:menu.albums];
            UIImageView *imageView=(UIImageView*)[cell.contentView viewWithTag:50];
            imageView.layer.cornerRadius=5;
            imageView.clipsToBounds=YES;
            [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
            UILabel *label=(UILabel*)[cell.contentView viewWithTag:150];
            label.text=menu.title;
            UILabel *detailLabel=(UILabel*)[cell.contentView viewWithTag:1000];
            detailLabel.text=menu.ingredients;
            cell.backgroundColor=[UIColor clearColor];

        }
        cell.selectionStyle=UITableViewCellEditingStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 140;
    }
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LEEDetailViewController *detailVC=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    LEEMenu *menu=self.allMenus[indexPath.row-2];
    NSArray *array=[LEEDataManager getALlMEnuSteps:menu];
    detailVC.steps=array;
    detailVC.str=menu.title;
    detailVC.menu=menu;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (IBAction)back:(UIBarButtonItem *)sender {
    [self.sideMenuViewController presentLeftMenuViewController];
}

-(void)sendResquestToServer{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *urlStr=@"http://apis.haoservice.com/lifeservice/cook/query";
        NSDictionary *param=@{
                              @"menu":(self.menuName.length==0?self.typeName:self.menuName),
                              @"pn":[NSString stringWithFormat:@"%ld",self.pg],
                              @"rn":[NSString stringWithFormat:@"%ld",self.rn],
                              @"key":@"54111801684e4b76bc86878692ef427f"
                              };
        [LEENetworkManager sendGetRequestWithUrl:urlStr parameters:param success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if (([responseObject[@"reason"] isEqualToString:@"查询无结果"])) {
                MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                HUD.delegate=self;
                HUD.color = [UIColor blackColor];
                HUD.labelText = @"无搜索内容,请重新搜索";
                HUD.dimBackground = YES;
                [HUD hide:YES afterDelay:2];
            }else{
                self.allMenus=[LEEDataManager getAllMenuData:responseObject];
            }
            NSLog(@"%ld",self.allMenus.count);
            [self.tableView1 reloadData];
        } failure:^(NSError *error) {
            NSLog(@"22");
        }];
   });
    
}


@end
