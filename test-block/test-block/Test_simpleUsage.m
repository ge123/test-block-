//
//  Test_simpleUsage.m
//  test-block
//
//  Created by 高召葛 on 2019/5/16.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import "Test_simpleUsage.h"

@implementation Test_simpleUsage

static Test_simpleUsage * _testObj;
static int m =7;
+ (instancetype) shareObj{
   
    @synchronized (self) {
    _testObj = [[self alloc] init];
    }
    
    return _testObj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _testObj = [super allocWithZone:zone];
    });
    return _testObj;
}

- (void) executeTest {

//    [self simpleUsage]; //   声明方式
    [self storageAboutBlockInMRC]; //   MRC内存相关
//    [self storageAboutBlockInARC]; //   ARC内存相关


}
/*
 MRC情况下内存相关：1. 位于代码区的block访问局部变量的都会复制到栈区 2. 访问局部全局、静态变量会加载到全局区 3、被copy修饰的block访问局部变量会被加载到堆区
 2019-05-17 09:08:01.133444+0800 test-block[44272:5574974] myblock 没有获取外部变量
 2019-05-17 09:08:01.133628+0800 test-block[44272:5574974] myblock: <__NSGlobalBlock__: 0x1067ea100>
 2019-05-17 09:08:01.133728+0800 test-block[44272:5574974] myblock2获取到局部变量：3
 2019-05-17 09:08:01.133895+0800 test-block[44272:5574974] myblock2: <__NSStackBlock__: 0x7ffee94159c0>
 2019-05-17 09:08:01.134000+0800 test-block[44272:5574974] myblock3获取到局部变量：3
 2019-05-17 09:08:01.134188+0800 test-block[44272:5574974] myblock3: <__NSStackBlock__: 0x7ffee9415970>
 2019-05-17 09:08:01.134353+0800 test-block[44272:5574974] myblock4获取到全局变量：7
 2019-05-17 09:08:01.134427+0800 test-block[44272:5574974] myblock4: <__NSGlobalBlock__: 0x1067ea170>
 2019-05-17 09:08:01.134529+0800 test-block[44272:5574974] 我是用copys修饰的属性block 加载局部变量 4
 2019-05-17 09:08:01.134752+0800 test-block[44272:5574974] myblockT1: <__NSMallocBlock__: 0x600002f8a5e0>
 2019-05-17 09:08:01.135106+0800 test-block[44272:5574974] 我是用copys修饰的属性block 加载q全局变量7
 2019-05-17 09:08:01.135668+0800 test-block[44272:5574974] myblockT2: <__NSGlobalBlock__: 0x1067ea190>
 */
- (void) storageAboutBlockInMRC{
//    void(^myblock)(void) = ^{
//        NSLog(@"myblock 没有获取外部变量");
//    };
//    myblock();
//    NSLog(@"myblock: %@",myblock); //  <__NSGlobalBlock__: 0x108d2d0f8>
//
//
//    int i=3;
//    void(^myblock2)(void) = ^{
//        NSLog(@"myblock2获取到局部变量：%d",i);
//    };
//    myblock2();
//    NSLog(@"myblock2: %@",myblock2); //   <__NSStackBlock__: 0x7ffee52969c0>
//
//
//    __block int h=3;
//    void(^myblock3)(void) = ^{
//        NSLog(@"myblock3获取到局部变量：%d",h);
//    };
//    myblock3();
//    NSLog(@"myblock3: %@",myblock3); //  <__NSStackBlock__: 0x7ffee5296970>
//
//
//    void(^myblock4)(void) = ^{
//        NSLog(@"myblock4获取到全局变量：%d",m);
//    };
//    myblock4();
//    NSLog(@"myblock4: %@",myblock4); //   myblock: <__NSGlobalBlock__: 0x10535d178>
//
    int l =4;
    self.myblockT1 = ^{
        NSLog(@"我是用copys修饰的属性block 加载局部变量 %d",l);
    };
    self.myblockT1();
    NSLog(@"myblockT1: %@",self.myblockT1); //    <__NSMallocBlock__: 0x60000107dce0>
    
    
    self.myblockT2 = ^{
        NSLog(@"我是用copys修饰的属性block 加载q全局变量%d",m);
    };
    self.myblockT2();
    NSLog(@"myblockT2: %@",self.myblockT2); //   myblock: <__NSGlobalBlock__: 0x10535d178>
    
    
//    __weak typeof(self)  weakobj = self;
//
//    __strong typeof(weakobj) strongObj = weakobj;
    
}

/*
 ARC只存在两种内存情况：  1. 获取局部变量的block都会复制到堆区  2. 获取全局、静态变量或者不获取变量都会加载搭配全局区
 2019-05-17 09:14:17.186183+0800 test-block[44562:5593068] myblock 没有获取外部变量
 2019-05-17 09:14:17.186344+0800 test-block[44562:5593068] myblock: <__NSGlobalBlock__: 0x1037881c8>
 2019-05-17 09:14:17.186433+0800 test-block[44562:5593068] myblock2获取到局部变量：3
 2019-05-17 09:14:17.186531+0800 test-block[44562:5593068] myblock2: <__NSMallocBlock__: 0x600001aec060>
 2019-05-17 09:14:17.186611+0800 test-block[44562:5593068] myblock3获取到局部变量：3
 2019-05-17 09:14:17.186681+0800 test-block[44562:5593068] myblock3: <__NSMallocBlock__: 0x600001aec0c0>
 2019-05-17 09:14:17.186763+0800 test-block[44562:5593068] myblock4获取到全局变量：7
 2019-05-17 09:14:17.186838+0800 test-block[44562:5593068] myblock4: <__NSGlobalBlock__: 0x1037881e8>
 2019-05-17 09:14:17.186920+0800 test-block[44562:5593068] 我是用copys修饰的属性block 加载局部变量 4
 2019-05-17 09:14:17.187008+0800 test-block[44562:5593068] myblockT1: <__NSMallocBlock__: 0x600001af5da0>
 2019-05-17 09:14:17.187103+0800 test-block[44562:5593068] 我是用copys修饰的属性block 加载q全局变量7
 2019-05-17 09:14:17.187326+0800 test-block[44562:5593068] myblockT2: <__NSGlobalBlock__: 0x103788208>

 */
- (void) storageAboutBlockInARC{
    
    void(^myblock)(void) = ^{
        NSLog(@"myblock 没有获取外部变量");
    };
    myblock();
    NSLog(@"myblock: %@",myblock);  // <__NSGlobalBlock__: 0x1037881c8>
    
    
    int i=3;
    void(^myblock2)(void) = ^{
        NSLog(@"myblock2获取到局部变量：%d",i);
    };
    myblock2();
    NSLog(@"myblock2: %@",myblock2); // <__NSMallocBlock__: 0x600001aec060>
    
    
    __block int h=3;
    void(^myblock3)(void) = ^{
        NSLog(@"myblock3获取到局部变量：%d",h);
    };
    myblock3();
    NSLog(@"myblock3: %@",myblock3); // <__NSMallocBlock__: 0x600001aec0c0>
    
    void(^myblock4)(void) = ^{
        NSLog(@"myblock4获取到全局变量：%d",m);
    };
    myblock4();
    NSLog(@"myblock4: %@",myblock4); //  <__NSGlobalBlock__: 0x1037881e8>
    
    int l =4;
    self.myblockT1 = ^{
        NSLog(@"我是用copys修饰的属性block 加载局部变量 %d",l);
    };
    self.myblockT1();
    NSLog(@"myblockT1: %@",self.myblockT1); // <__NSMallocBlock__: 0x600001af5da0>
    
    
    self.myblockT2 = ^{
        NSLog(@"我是用copys修饰的属性block 加载q全局变量%d",m);
    };
    self.myblockT2();
    NSLog(@"myblockT2: %@",self.myblockT2);  // <__NSGlobalBlock__: 0x103788208>

}


/*
 声明方式：
 */
- (void) simpleUsage
{
//    使用方式一：
    void(^myblock1)(void) = ^{
        NSLog(@"没有参数没有返回值的block");
    };
//    使用方式二：
    NSString*(^myblock2)(void) = ^{
        return @"有返回值没有参数的block";
    };
//    使用后方式三：
    void(^myblock3)(NSString*) = ^(NSString * a){
        NSLog(@"%@",[NSString stringWithFormat:@"没有返回值 有参数:%@",a]) ;
    };

}

@end
