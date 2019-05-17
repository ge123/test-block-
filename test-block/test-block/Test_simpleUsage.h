//
//  Test_simpleUsage.h
//  test-block
//
//  Created by 高召葛 on 2019/5/16.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^myblockTemplate) (void);

@interface Test_simpleUsage : NSObject

@property (copy,nonnull) myblockTemplate myblockT1;
@property (copy,nonnull) myblockTemplate myblockT2;

+ (instancetype) shareObj;
- (void) executeTest;
@end

NS_ASSUME_NONNULL_END
