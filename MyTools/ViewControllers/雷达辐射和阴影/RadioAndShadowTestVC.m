//
//  RadioAndShadowTestVC.m
//  MyTools
//
//  Created by SongGuoxing on 2018/4/10.
//  Copyright © 2018年 Xing. All rights reserved.
//

#import "RadioAndShadowTestVC.h"
#import "LXBasicController.h"
@interface RadioAndShadowTestVC ()
@property(nonatomic,strong)NSArray *dataA;
@end

@implementation RadioAndShadowTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIView设置局部阴影";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataA.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataA[indexPath.row];
    // Configure the cell...
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LXBasicController *changeVc =[[LXBasicController alloc]init];
    /** 加载GIF图
     NSString *path = [[NSBundle mainBundle] pathForResource:@"gif11111" ofType:@"gif"];
     NSData *data = [NSData dataWithContentsOfFile:path];
     UIImage *image = [UIImage sd_animatedGIFWithData:data];
     self.userIcon.image = image;

     */
    switch (indexPath.row) {
        case 0:
            changeVc.shadowPathSide = LXShadowPathTop;
            break;
        case 1:
            changeVc.shadowPathSide = LXShadowPathBottom;
            break;
            
        case 2:
            changeVc.shadowPathSide = LXShadowPathLeft;
            break;
        case 3:
            changeVc.shadowPathSide = LXShadowPathRight;
            break;
        case 4:
            changeVc.shadowPathSide = LXShadowPathNoTop;
            break;
            
        case 5:
            changeVc.shadowPathSide = LXShadowPathAllSide;
            break;
            
        case 6:
            changeVc.radarType = 1;
            break;
        case 7:
            changeVc.radarType = 2;
            break;
        case 8:
            changeVc.radarType = 3;
            break;

    }
    
    [self.navigationController pushViewController:changeVc animated:YES];
}

-(NSArray *)dataA{
    if (!_dataA) {
        _dataA  = @[@"顶部阴影",@"底部阴影",@"左侧阴影",@"右侧阴影",@"左右底部阴影",@"四周",@"雷达辐射",@"雷达辐射1",@"雷达扫描"];
    }
    return _dataA;
}

@end
