//
//  TPViewController.m
//  TPNetworking
//
//  Created by Topredator on 10/25/2020.
//  Copyright (c) 2020 Topredator. All rights reserved.
//

#import "TPViewController.h"

#import "TPTestTask.h"
#import "TPUserTask.h"


@interface TPViewController ()

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.'
    
    TPUserTask *task = [TPUserTask task];
    task.req_token = @"123";
    [[task get] subscribeNext:^(TPUserTask *x) {
        [x saveTask];
    } error:^(NSError * _Nullable error) {
        
    }];
    [self setupSubviews];
}

- (void)setupSubviews {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 40)];
    [btn setTitle:@"123" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click123) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.backgroundColor = UIColor.blueColor;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 40)];
    [btn1 setTitle:@"456" forState:UIControlStateNormal];
    [btn1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click456) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    btn1.backgroundColor = UIColor.blueColor;
    [self.view addSubview:btn1];
}

- (void)click123 {
    TPUserTask *task = [TPUserTask fetchTask:@"123"];
    NSLog(@"123是否存在 = %@", task.dic);
}
- (void)click456 {
    NSLog(@"456是否存在 = %@", [TPUserTask fetchTask:@"456"]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
