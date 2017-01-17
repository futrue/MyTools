//
//  FMDatabase+Category.h
//  sqlitDemo
//
//  Created by 曾墨 on 15/7/10.
//  Copyright (c) 2015年  All rights reserved.
//

#define KEY_VALUE(KEY,VALUE) [NSString stringWithFormat:@"%@ = '%@'",KEY,VALUE]

#define WHERE_KEY_VALUE(KEY,VALUE) KEY_VALUE(KEY,VALUE)

#define INSERTAQL(TABLENAME,KeyS,ValueS) [NSString stringWithFormat:@"INSERT INTO '%@' (%@) VALUES (%@)",TABLENAME,KeyS, ValueS]

#define DELEATESQL(TABLENAME,KEY,VALUE) [NSString stringWithFormat:@"delete from %@ where %@",TABLENAME, KEY_VALUE(KEY,VALUE)]

#define UPDATESQL(tableName,setKey,setValue,whereKey,whereValue) [NSString stringWithFormat:@"update %@ set %@ where %@",tableName, KEY_VALUE(setKey,setValue) , KEY_VALUE(whereKey,whereValue)]

#define SEARCHSQL(TABLENAME) [NSString stringWithFormat:@"select * from %@",TABLENAME]

#define SEARCHSQL_KV(TABLENAME,KEY,VALUE) [NSString stringWithFormat:@"select * from %@ where %@",TABLENAME,KEY_VALUE(KEY, VALUE)]


#import "FMDB.h"
#import "FMDatabase.h"

@interface FMDatabase (Category)

#pragma mark - db

/**  
 获取fmdb实例
 
 @param squliteName 数据库名称
 */
+(FMDatabase *)databaseWithName:(NSString *)squliteName;

/** 创建数据库  */
-(BOOL)createTablesSql:(NSString *)sqlCreateTable;

#pragma mark - 增加

/** 插入 */
-(BOOL)insertSql:(NSString *)insertSql;

/*!
 @brief  插入数据
 
 @param tableName tableName
 @param keys      keys = [NSString stringWithFormat:@"'%@','%@'",NAME, AGE];
 @param values    values = [NSString stringWithFormat:@"'%@','%@'",@"张三", @"13"];
 */
-(BOOL)insertSqlFromTableName:(NSString *)tableName keys:(NSString*)keys values:(NSString*)values;

#pragma mark - 更新

/*!
 @brief  更新数据
 @param updateSql (str)updateSql
 */
-(BOOL)updateSql:(NSString *)updateSql;

/*!
 @brief  更新数据
 @param tableName  tableName
 @param Key,Value  Where KEY_VALUE(whereKey,whereValue)
 */
-(BOOL)updateSqlFromTableName:(NSString *)tableName setKey:(NSString *)setKey setValue:(NSString *)setValue whereKey:(NSString *)whereKey whereValue:(NSString *)whereValue;

#pragma mark - 删除

/** 删除 */
-(BOOL)deleteSql:(NSString *)deleteSql;

/*!
 @brief  删除
 @param tableName   tableName
 @param Key,Value   Where KEY_VALUE(whereKey,whereValue)]
 */
-(BOOL)deleteSqlFromTableName:(NSString *)tableName key:(NSString *)key value:(NSString *)value;

/*!
 @brief  删除表格
 @param tableName tableName
 */
- (BOOL) deleteTable:(NSString *)tableName;

/*!
 @brief  清空表 清除数据
 @param tableName tableName
 */
- (BOOL) eraseTable:(NSString *)tableName;

/*!
 @brief  清除表中符合条件的数据
 @param tableName   tableName
 @param where       KEY_VALUE(whereKey,whereValue)]
 */
- (BOOL) eraseTable:(NSString *)tableName where:(NSString*)where;

#pragma mark - 查询

/*!
 查询 
 //FIXME: 操作结束后需要关闭数据库 [db close];//!!!: 待改进 
 //FIXME: 建议使用-(void)searchSql:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock;
 @return    查询结果集
 */
-(FMResultSet *)searchSql:(NSString *)sql;

/*!
 @brief  查询
 @param searchSql searchSql
 @param           查询结果集
 */
-(void)searchSql:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock;

#pragma mark - toDoBlock
/*!
 @brief  执行操作
 @param toDoBlock 打开数据库 -> 执行操作(block) -> 关闭数据库
 */
- (BOOL) dbToDoWork:(BOOL (^)())toDoBlock;

@end
