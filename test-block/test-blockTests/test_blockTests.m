//
//  test_blockTests.m
//  test-blockTests
//
//  Created by 高召葛 on 2019/5/16.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface test_blockTests : XCTestCase

@end

@implementation test_blockTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
