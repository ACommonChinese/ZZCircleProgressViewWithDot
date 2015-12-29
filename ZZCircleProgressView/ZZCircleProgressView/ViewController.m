//
//  ViewController.m
//  ZZCircleProgressView
//
//  Created by 刘威振 on 12/22/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "ZZCircleProgressView.h"

@interface ViewController ()

@property (nonatomic) ZZCircleProgressView *progressView;
@end

@implementation ViewController

- (IBAction)click:(id)sender {
    self.progressView.progress += 0.05;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.progressView = [[ZZCircleProgressView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    
    // ZZCircleProgressView *progressView = [[ZZCircleProgressView alloc] init];
    // progressView.frame = CGRectMake(100, 100, 200, 200);
    _progressView.backgroundColor = [UIColor yellowColor];
    _progressView.trackColor      = [UIColor whiteColor];
    _progressView.progressColor   = [UIColor greenColor];
    _progressView.progress        = 0.0f;
    _progressView.progressWidth   = 20;
    _progressView.showProgressIndicator = YES;
    
    // progressView.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:_progressView];
}

@end
