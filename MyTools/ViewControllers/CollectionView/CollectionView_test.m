//
//  CollectionView_test.m
//  MyTools
//
//  Created by SGX on 17/1/9.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "CollectionView_test.h"

static NSString *tableViewID = @"t_cell";
static NSString *collectionViewID = @"c_cell";
static NSString *collectionViewHeaderID = @"header";
static NSString *collectionViewFooterID = @"footer";

@interface CollectionView_test ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *categoryArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isRelated;


@end

@implementation CollectionView_test

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BgColor;
    self.navigationItem.title = @"商品分类";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = BgColor;
    
    self.categoryArr = @[@"古玩收藏",@"工艺一品",@"数码相机",@"男女饰品",@"品牌手表",@"男女包包",@"电脑手机",@"居家用品",@"运动休闲"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc ] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH/4, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2; // 行间距
        layout.minimumInteritemSpacing = 2;// 列间距
        CGFloat w = self.view.frame.size.width/4.0 - 4;
        layout.itemSize = CGSizeMake(w, w);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, 64, SCREEN_WIDTH*3/4, SCREEN_HEIGHT-64) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionViewFooterID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewID forIndexPath:indexPath];
    cell.textLabel.text = self.categoryArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor redColor];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    selectedBackgroundView.alpha = 0.8;
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 5, 40)];
    lineLabel.backgroundColor = [UIColor blueColor];
    [selectedBackgroundView addSubview:lineLabel];
    cell.selectedBackgroundView = selectedBackgroundView;//自定义cell选中时的背景

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        self.isRelated = NO;
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        //将CollectionView的滑动范围调整到tableView相对应的cell的内容
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.categoryArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

//如果用头视图的方法进行相关联会出现，透视图的分类标题不能显示在可视范围
//设置头视图的尺寸，如果想要使用头视图，则必须实现该方法和 -(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath 方法
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    // return CGSizeMake(WIDTH*3/4, 30);
    return CGSizeMake(SCREEN_WIDTH*3/4,1);//在此如果将头视图的尺寸设置为（0，0）则左侧的tableView的分类cell不会根据collectionView的滑动而滑到相应的分类的cell。
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //根据类型以及标识获取注册过的头视图,
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderID forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];

    for (UIView *view in headerView.subviews) {
        [view removeFromSuperview];
    }
    
     UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
     label.text = self.categoryArr[indexPath.section];
     [headerView addSubview:label];
     label.textColor = [UIColor whiteColor];
    return headerView;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    if(indexPath.item == 0)
    {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
        
        UILabel *titleTextLable = [[UILabel alloc]initWithFrame:cell.frame];
        titleTextLable.textColor = [UIColor whiteColor];
        titleTextLable.text = self.categoryArr[indexPath.section];
        titleTextLable.backgroundColor = [UIColor redColor];
        cell.backgroundView = titleTextLable;
        cell.userInteractionEnabled = NO;
    }else
    {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
        
        cell.userInteractionEnabled = YES;
    }

    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20,0,20,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.item == 0){
        return CGSizeMake(self.view.frame.size.width - SCREEN_WIDTH/4, 40);
    }
    CGFloat w = self.view.frame.size.width/4.0 - 4;
    return CGSizeMake(w, w);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"collectionView didselected section:%zi item:%zi",indexPath.section,indexPath.item);
}


//将显示视图
-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (self.isRelated) {
        
        NSInteger topcellsection = [[[collectionView indexPathsForVisibleItems]firstObject]section];
        if (collectionView == _collectionView) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topcellsection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            
        }
    }
}
//将结束显示视图
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if (self.isRelated) {
        NSInteger itemsection = [[[collectionView indexPathsForVisibleItems]firstObject]section];
        if (collectionView == _collectionView) {
            
            //当collectionView滑动时，tableView的cell自动选中相应的分类
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:itemsection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.isRelated = YES;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array =  tableView.indexPathsForVisibleRows;
    NSIndexPath *firstIndexPath = array[0];
    
    //设置anchorPoint
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    //为了防止cell视图移动，重新把cell放回原来的位置
    cell.layer.position = CGPointMake(0, cell.layer.position.y);
    
    //设置cell 按照z轴旋转90度，注意是弧度
    if (firstIndexPath.row < indexPath.row) {
        cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0);
    }else{
        cell.layer.transform = CATransform3DMakeRotation(- M_PI_2, 0, 0, 1.0);
    }
    
    cell.alpha = 0.0;
    
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1.0;
    }];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row % 2 != 0) {
        cell.transform = CGAffineTransformTranslate(cell.transform, kScreenWidth/2, 0);
    }else{
        cell.transform = CGAffineTransformTranslate(cell.transform, -kScreenWidth/2, 0);
    }
    cell.alpha = 0.0;
    [UIView animateWithDuration:0.7 animations:^{
        cell.transform = CGAffineTransformIdentity;
        cell.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}
@end
