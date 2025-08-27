//
//  DataBaseManger.h
//  Daily
//
//  Created by nanxun on 2024/11/13.
//

#import <Foundation/Foundation.h>
#import "fmdb/FMDB.h"
NS_ASSUME_NONNULL_BEGIN

@interface DataBaseManger : NSObject
@property (nonatomic, strong) FMDatabase* db;
@property (nonatomic, strong) NSString* sqlFilePath;
+(instancetype)ShareDateBaseManger;
-(void)Print;
@end

NS_ASSUME_NONNULL_END
