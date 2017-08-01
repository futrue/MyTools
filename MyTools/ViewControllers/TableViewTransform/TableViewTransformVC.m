//
//  TableViewTransformVC.m
//  MyTools
//
//  Created by SongGuoxing on 2017/7/27.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "TableViewTransformVC.h"

@interface TableViewTransformVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TableViewTransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeLeft;
    self.view.backgroundColor = BgColor;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = RandomColor;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     http://www.jianshu.com/p/e255ad33fb1a
     http://www.jianshu.com/p/78c30ccf425f
     向右为x轴正方向,向下为y轴正方向,垂直屏幕向外为z轴正方向
     */
    CATransform3D transform;//3D旋转
    // 有Make 实现形变（Transform）
    // 无Make 基于一个已经存在的形变，也就是上面带Make的Transform
    transform = CATransform3DMakeRotation( M_PI_4 , 0.0, 0.7, 0.4);
    //逆时针旋转
    transform = CATransform3DScale(transform, 0.8, 0.8, 1);
    
    transform.m34 = 1.0/ 1000;
    /* m34:在默认情况下,系统采用正交投影,对于3D形变实际上是看不到3D效果的,在CATransform3D结构体中有一个m34便允许我们将正交投影修改为有      
           近大远小立体效果的透视投影,其中m34 = -1.0/z,这个z为观察者与控件之间的距离
     */
    cell.layer.shadowColor = [[UIColor redColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
//    cell.layer.transform = rotation;
    
    // -------------
    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:0.6];
//    cell.layer.transform = CATransform3DIdentity;
//    cell.layer.transform = CATransform3DMakeRotation(M_PI*0.3, 0, 1, 1);
//    cell.layer.transform = CATransform3DMakeTranslation(30, 20, 10);
//    cell.layer.transform = CATransform3DMakeScale(2, 0.5, 1);
    cell.layer.transform = CATransform3DTranslate(transform, 50, 0, 10);
    cell.layer.transform = CATransform3DScale(transform, 2, 0.5, 1);
    cell.layer.transform = CATransform3DRotate(transform, M_PI*0.25, 1, 0, 0);
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];

}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80.f;
    }
    return _tableView;
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
