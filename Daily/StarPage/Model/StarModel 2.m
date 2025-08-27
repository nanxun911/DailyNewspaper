//
//  StarModel.m
//  Daily
//
//  Created by nanxun on 2024/11/13.
//

#import "StarModel.h"

@implementation StarModel
-(void)insertData {
    NSString* sqlInsert = @"INSERT INTO  collectionCenter (webPageId, webPageTitle, webImageURL, likes, star) VALUES (?, ?, ?, ?, ?)";
    if ([[DataBaseManger ShareDateBaseManger].db open]) {
        BOOL flag = [[DataBaseManger ShareDateBaseManger].db executeUpdate:sqlInsert, self.webPageId, self.titile, self.imageUrl, @(self.selectLike), @(self.selectStar)];
        if (flag) {
            NSLog(@"success");
        } else {
            NSLog(@"error");
        }
    }
    
}
-(void)deleteData {
    NSString* sqlDelete = @"delete from collectionCenter where (webPageId) = (?) and (webPageTitle) = (?) and (webImageURL) = (?) and (likes) = (?) and (star) = (?)";
    if ([[DataBaseManger ShareDateBaseManger].db open]) {
        BOOL flag = [[DataBaseManger ShareDateBaseManger].db executeUpdate:sqlDelete, self.webPageId, self.titile, self.imageUrl, self.selectLike, self.selectStar];
        if (flag) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}
-(void)changeData {
    NSString* sqlDelete = @"update collectionCenter set (star) = (?) where (webPageId) = (?)";
    if ([[DataBaseManger ShareDateBaseManger].db open]) {
        BOOL flag = [[DataBaseManger ShareDateBaseManger].db executeUpdate:sqlDelete, @(self.selectStar), self.webPageId];
        if (flag) {
            NSLog(@"修改数据成功");
        } else {
            NSLog(@"修改数据失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}
-(void)changeLike {
    NSString* sqlDelete = @"update collectionCenter set (likes) = (?) where (webPageId) = (?)";
    if ([[DataBaseManger ShareDateBaseManger].db open]) {
        BOOL flag = [[DataBaseManger ShareDateBaseManger].db executeUpdate:sqlDelete, @(self.selectLike), self.webPageId];
        if (flag) {
            NSLog(@"修改数据成功");
        } else {
            NSLog(@"修改数据失败");
        }
    } else {
        NSLog(@"打开数据库失败");
    }
}
@end
