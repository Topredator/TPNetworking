//
//  TPViewController.m
//  TPNetworking
//
//  Created by Topredator on 10/25/2020.
//  Copyright (c) 2020 Topredator. All rights reserved.
//

#import "TPViewController.h"

#import "TPTestTask.h"

@interface TPViewController ()

@end

@implementation TPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.'
    [[[TPTestTask task] get] subscribeNext:^(TPTestTask *x) {
        NSLog(@"success = %@", x.serverTotalResponseData);
    } error:^(NSError * _Nullable error) {
        NSLog(@"err = %@", error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
