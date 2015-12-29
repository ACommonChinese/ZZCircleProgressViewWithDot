# ZZCircleProgressViewWithDot
圆型进度with圆点进度指示符

Circle progress view

###使用方法
```
- (IBAction)click:(id)sender {
    self.progressView.progress += 0.05;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.progressView = [[ZZCircleProgressView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    _progressView.backgroundColor = [UIColor yellowColor];
    _progressView.trackColor      = [UIColor whiteColor];
    _progressView.progressColor   = [UIColor greenColor];
    _progressView.progress        = 0.0f;
    _progressView.progressWidth   = 20;
    _progressView.showProgressIndicator = YES;
    [self.view addSubview:_progressView];
}

```

###效果图
![](./1.png)

###进度小圆点计算公式(高中三角函数)
![](./2.png)

