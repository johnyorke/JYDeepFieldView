//
//  JYDeepFieldViewController.m
//  DeepFieldSampleApp
//
//  Created by John Yorke on 16/07/2014.
//  Copyright (c) 2014 John Yorke. All rights reserved.
//

#import "JYDeepFieldViewController.h"
#import "JYDeepFieldView.h"

@interface JYDeepFieldViewController ()

@end

@implementation JYDeepFieldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    JYDeepFieldView *deepField = [[JYDeepFieldView alloc] initWithFrame:self.view.frame];
    
    deepField.backImage = [UIImage imageNamed:@"back"];
    deepField.middleImage = [UIImage imageNamed:@"middle"];
    deepField.frontImage = [UIImage imageNamed:@"front"];
    
    [self.view addSubview:deepField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
