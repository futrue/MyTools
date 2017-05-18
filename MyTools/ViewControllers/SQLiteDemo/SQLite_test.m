//
//  SQLite_test.m
//  MyTools
//
//  Created by SGX on 17/1/17.
//  Copyright © 2017年 Xing. All rights reserved.
//

#import "SQLite_test.h"
#import "FMDatabase+Category.h"

#define DATABASE @"database"
#define TABLENAME @"tbName"
#define ID @"id"
#define NAME @"name"
#define AGE @"age"
#define ADDRESS @"address"

@interface SQLite_test ()
{
    FMDatabase *db;
}
@property (nonatomic , strong) NSArray  *btnTitleArray;
@property (nonatomic , strong) NSArray  *btnActionArray;


@end

@implementation SQLite_test

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"创建");
    db = [FMDatabase databaseWithName:DATABASE];
    [self addSubview];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - fmdb

-(void)build
{
    NSLog(@"建表");
    // 创建表格 INTEGER PRIMARY KEY AUTOINCREMENT 为自动增长整形
    NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
    [db createTablesSql:sqlCreateTable];
}

-(void)insertSql
{
#pragma mark 方式一
    NSString *insertSql1= [NSString stringWithFormat:
                           @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                           TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
    ([db insertSql:insertSql1])? NSLog(@"插入成功%@",insertSql1): NSLog(@"插入失败");
    
#pragma mark 方式二
    NSString *keys = [NSString stringWithFormat:@"'%@','%@','%@'",NAME, AGE, ADDRESS];
    NSString *values = [NSString stringWithFormat:@"'%@','%@','%@'",@"李四", @"19", @"北京"];
    insertSql1 = INSERTAQL(TABLENAME, keys, values);
    ([db insertSql:insertSql1])? NSLog(@"插入成功%@",insertSql1): NSLog(@"插入失败");
}

-(void)updateSql
{
    //修改数据：
#pragma mark 方式一
    NSString *updateSql = [NSString stringWithFormat:
                           @"update %@ set %@ = '%@' where %@ = '%@'",
                           TABLENAME,  AGE,  @18 ,NAME,  @"张三"];
#pragma mark 方式二
    updateSql = UPDATESQL(TABLENAME, AGE, @19, NAME, @"张三");
    ([db updateSql:updateSql])? NSLog(@"更新成功%@",updateSql): NSLog(@"更新失败");
    //    [db updateSqlFromTableName:TABLENAME setKey:AGE setValue:@"20" whereKey:NAME whereValue:@"张三"];
}

-(void)deleteSql
{
    ([db deleteSqlFromTableName:TABLENAME key:NAME value:@"张三"])? NSLog(@"删除成功"): NSLog(@"删除失败");
}

-(void)searchSql
{
    NSLog(@"查询");
#pragma mark 方式一
    //    NSString * sql = [NSString stringWithFormat:@"select * from %@",TABLENAME];
#pragma mark 方式二
    NSString * sql1 = SEARCHSQL(TABLENAME);
#pragma mark 条件查询
    //    sql1 = SEARCHSQL_KV(TABLENAME, ID, @"13");
    [db searchSql:sql1 queryResBlock:^(FMResultSet *set) {
        while ([set next]) {
            int Id = [set intForColumn:ID];
            NSString * name = [set stringForColumn:NAME];
            NSString * age = [set stringForColumn:AGE];
            NSString * address = [set stringForColumn:ADDRESS];
            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
        }
    }];
}

#pragma mark - 构建子界面
-(void)addSubview
{
    for (int i = 0; i < self.btnTitleArray.count ; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake(0, 0, 200, 30);
        btn.center = CGPointMake(320/2, 480*(i+1)/(self.btnTitleArray.count+1));
        [btn setTitle:self.btnTitleArray[i] forState:UIControlStateNormal];
        (i<_btnTitleArray.count-1)?[btn addTarget:self action:NSSelectorFromString(self.btnActionArray[i]) forControlEvents:UIControlEventTouchUpInside]:nil;
        [self.view addSubview:btn];
    }
}

#pragma mark - getter
-(NSArray *)btnTitleArray
{
    if (_btnTitleArray == nil) {
        _btnTitleArray = @[@"建表",@"插入",@"修改",@"删除",@"查询",@"请在控制台查看结果"];
        _btnActionArray = @[@"build",@"insertSql",@"updateSql",@"deleteSql",@"searchSql",@""];
    }
    return _btnTitleArray;
}


@end
