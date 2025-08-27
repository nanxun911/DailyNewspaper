//
//  DataBaseManger.m
//  Daily
//
//  Created by nanxun on 2024/11/13.
//

#import "DataBaseManger.h"
static id DataManger = nil;
@implementation DataBaseManger
+(instancetype)ShareDateBaseManger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DataManger = [[super allocWithZone:NULL] init];
        [DataManger creatDateBase];
    });
    return DataManger;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [DataBaseManger ShareDateBaseManger];
}
- (void)creatDateBase {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    self.sqlFilePath = [path stringByAppendingPathComponent:@"collectionCenter.sqlite"];
    self.db = [FMDatabase databaseWithPath:_sqlFilePath];
    //[self delete];
    
    if ([self.db open]) {
        NSString *query = [NSString stringWithFormat:@"PRAGMA table_info(collectionCenter)"];
        FMResultSet *resultSet = [self.db executeQuery:query];
                
        NSMutableArray *columnNames = [NSMutableArray array];
                
        while ([resultSet next]) {
            NSString *columnName = [resultSet stringForColumn:@"name"];
            [columnNames addObject:columnName];
        }
        NSLog(@"Table columns: %@", columnNames);
        NSLog(@"load success");
    } else {
        NSLog(@"error");
    }
}
-(void)Print {
    if ([self.db open]) {
        NSString *selectSql = @"select * from collectionCenter";
        FMResultSet* set = [self.db executeQuery:selectSql];
        while ([set next]) {
            NSString* pageId = [set stringForColumn:@"webPageId"];
            NSString* title = [set stringForColumn:@"webPageTitle"];
            NSString* url = [set stringForColumn:@"webImageURL"];
            NSLog(@"%@, %@, %@", pageId, title, url);
        }
    } else {
        NSLog(@"load error");
    }
}
-(void)delete {
    

    if ([self.db open]) {
        // 获取所有表名
        FMResultSet *resultSet = [self.db executeQuery:@"SELECT name FROM sqlite_master WHERE type='table'"];
        NSMutableArray *tables = [NSMutableArray array];
        
        while ([resultSet next]) {
            NSString *tableName = [resultSet stringForColumn:@"name"];
            if (![tableName isEqualToString:@"sqlite_sequence"]) { // 不清空自动增长ID表
                [tables addObject:tableName];
            }
        }
        
        // 删除所有表数据
        for (NSString *tableName in tables) {
            NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
            if ([self.db executeUpdate:deleteSQL]) {
                NSLog(@"清空表 %@ 成功", tableName);
            } else {
                NSLog(@"清空表 %@ 失败: %@", tableName, [self.db lastErrorMessage]);
            }
        }
        
        [self.db close];
    } else {
        NSLog(@"无法打开数据库");
    }
}
-(void)insertColumn {
    if ([self.db open]) {
        NSString *sql = @"ALTER TABLE collectionCenter ADD COLUMN star Boolean DEFAULT 0;";
        BOOL success = [self.db executeUpdate:sql];
        if (success) {
            NSLog(@"添加新列成功");
        }
    } else {
        NSLog(@"load error");
    }
}
@end
