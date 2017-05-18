//
//  Wave&DropDown.m
//  MyTools
//
//  Created by SGX on 17/1/13.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "Wave&DropDown.h"
#import "JSWave.h"

@interface Wave_DropDown ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) JSWave *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property(nonatomic,strong)UIImageView *iconImageview;
@property(nonatomic,strong)UIView *NavView;//导航栏

@end

@implementation Wave_DropDown

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iconImageview.frame = CGRectMake(0, -self.view.bounds.size.width/1.5, self.view.bounds.size.width, self.view.bounds.size.width/1.5);
    [self.iconImageview addSubview:self.headerView];
    self.iconImageview.contentMode=UIViewContentModeScaleAspectFill;
    //6.设置autoresizesSubviews让子类自动布局
    self.iconImageview.autoresizesSubviews = YES;
    [self.tableView addSubview:self.iconImageview];
    [self.view addSubview:self.NavView];
    [self.view addSubview:self.tableView];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"
                                                            forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"第%zi行",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected :%zi",indexPath.row);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y=scrollView.contentOffset.y;
    if(y< -self.view.bounds.size.width/1.5)
    {
        
        CGRect frame= self.iconImageview.frame;
        frame.origin.y=y;
        frame.size.height=-y;
        self.iconImageview.frame=frame;
        //        _headerView.frame= CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.width/3/2. + self.iconImageview.bounds.size.height/2.)*0.95);
        _headerView.center = CGPointMake(self.view.bounds.size.width/2., -y/2. + (-y - self.headerView.bounds.size.height)/2.);
        //        self.icon.mj_centerY = self.iconImageview.height/2.;
        //        self.nickName.y = CGRectGetMaxY(self.icon.frame) + SCALE*5;
        //        self.bgImageView.height = CGRectGetMaxY(self.icon.frame)*0.95;
        //        self.lines.y = self.iconImageview.height - 1;
        //        self.toolbar.frame = self.iconImageview.bounds;
        //       self.effectView.frame = self.zoomImageView.bounds;
        
        //        CFShow((__bridge CFTypeRef)(NSStringFromCGRect(self.iconImageview.frame)));
        
    }
    
    NSLog(@"----%f----haha%f",self.view.bounds.size.width/1.5 - 64,y + self.view.bounds.size.width/1.5);
    
    if ( y + self.view.bounds.size.width/1.5 > 0) {
        
        self.NavView.alpha= (y + self.view.bounds.size.width/1.5)/150.;
        self.NavView.backgroundColor=[UIColor purpleColor];
        //状态栏字体白色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
        
    }else{
        
        self.NavView.alpha=1;
        //self.NavView.title
        //        self.NavView.backTitleImage=@"Mail-click";
        //        self.NavView.rightImageView=@"Setting-click";
        self.NavView.backgroundColor= [UIColor clearColor];
        //隐藏黑线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        //状态栏字体黑色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    }
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(self.view.bounds.size.width/1.5, 0, 0, 0);
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView.sectionFooterHeight = 0.01;
        _tableView.contentSize = CGSizeMake(0, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = YES;//showsHorizontalScrollIndicator
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];

    }
    return _tableView;
}

- (UIView *)NavView {
    if (!_NavView) {
        _NavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        _NavView.backgroundColor = [UIColor redColor];
        _NavView.alpha=0;
    }
    return _NavView;
}

- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.headerView.frame.size.width/2-30, 0, 60, 60)];
        _iconImageView.layer.borderColor = [UIColor orangeColor].CGColor;
        _iconImageView.layer.borderWidth = 2;
        _iconImageView.layer.cornerRadius = 20;
        
    }
    return _iconImageView;
}

- (UIImageView *)iconImageview {
    if(_iconImageview == nil) {
        
        _iconImageview = [[UIImageView alloc] init];
        _iconImageview.image = [UIView imageWithRoundedCornersSize:10 usingImage:[UIImage imageNamed:@"beijing"]];
        _iconImageview.backgroundColor = [UIColor orangeColor];
        _iconImageview.userInteractionEnabled = YES;
        
    }
    return _iconImageview;
}

- (JSWave *)headerView{
    
    if (!_headerView) {
        //        _headerView = [[JSWave alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _headerView = [[JSWave alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.width/3/2. + self.iconImageview.bounds.size.height/2.)*0.95)];
        
        _headerView.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.width/1.5/2.+(self.iconImageview.bounds.size.height - self.headerView.bounds.size.height)/2.);
        
        //        _headerView.backgroundColor = XNColor(248, 64, 87, 1);
        //        _headerView.maskWaveColor = [UIColor purpleColor];
        _headerView.realWaveColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing"]];
        _headerView.backgroundColor = [UIColor clearColor];
        
        
        [_headerView addSubview:self.iconImageView];
        __weak typeof(self)weakSelf = self;
        _headerView.waveBlock = ^(CGFloat currentY){
            CGRect iconFrame = [weakSelf.iconImageView frame];
            iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.iconImageView.frame)+currentY-weakSelf.headerView.waveHeight;
            
            weakSelf.iconImageView.frame  =iconFrame;
        };
        [_headerView startWaveAnimation];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
