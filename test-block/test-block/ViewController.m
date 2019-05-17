//
//  ViewController.m
//  test-block
//
//  Created by 高召葛 on 2019/5/16.
//  Copyright © 2019 高召葛. All rights reserved.
//

#import "ViewController.h"
#import "Test_simpleUsage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[Test_simpleUsage shareObj] executeTest];
}


@end
