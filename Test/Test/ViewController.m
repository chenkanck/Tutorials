//
//  ViewController.m
//  Test
//
//  Created by Kan Chen on 4/22/16.
//  Copyright © 2016 Kan Chen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dict = @{@"id": @"po"};
    NSInteger i = [dict[@"id"] integerValue];
    NSLog(@"%d", i);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
