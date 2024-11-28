//
//  StarModel.h
//  Daily
//
//  Created by nanxun on 2024/11/13.
//

#import <Foundation/Foundation.h>
#import "DataBaseManger.h"
NS_ASSUME_NONNULL_BEGIN

@interface StarModel : NSObject
@property (nonatomic, copy) NSString* titile;
@property (nonatomic, copy) NSString* imageUrl;
@property (nonatomic, copy) NSString* webPageId;
@property (nonatomic, assign) NSInteger selectLike;
@property (nonatomic, assign) NSInteger selectStar;
-(void)insertData;
-(void)deleteData;
-(void)changeData;
-(void)changeLike;
@end

NS_ASSUME_NONNULL_END
