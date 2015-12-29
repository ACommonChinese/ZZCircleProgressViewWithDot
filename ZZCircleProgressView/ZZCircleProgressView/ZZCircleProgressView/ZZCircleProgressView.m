//
//  ZZCircleProgressView.m
//  ZZCircleProgressView
//
//  Created by 刘威振 on 12/22/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//
//  http://blog.csdn.net/volcan1987/article/details/9969455

/**
 *  1. 使用UIBezierPath创建路径path(扇形)
 *  2. 使用CAShapeLayer创建层shapeLayer(扇形)
 *  3. shapeLayer.path = path
 *  4. 把shapeLayer添加到某图形的layer中
 
 *  注：为了只显示线条，设置扇形的填充色为空，线条颜色不为空，线条宽度大于0，这样就只显示线条了
 */

#import "ZZCircleProgressView.h"
#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
#define PROGRESS_LINE_WIDTH 20 //弧线的宽度
#define  PROGREESS_WIDTH 180 //圆直径

#define R (CGRectGetMidX(self.bounds) - self.progressWidth/2.0)

@interface ZZCircleProgressView ()

@property (nonatomic) CAShapeLayer *trackLayer;
@property (nonatomic) CAShapeLayer *progressLayer;
@property (nonatomic) UIImageView *indicatorView;
@end

@implementation ZZCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addLayers];
        return self;
    }
    return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addLayers];
        return self;
    }
    return nil;
}

- (void)addLayers {
    [self addTrackLayer];    // Track Layer
    [self addProgressLayer]; // Progress Layer
    
    // Progress Width Default: 20
     self.progressWidth = 20.0;
}

- (void)addTrackLayer {
    self.trackLayer       = [[CAShapeLayer alloc] init];
    _trackLayer.fillColor = nil;
    _trackLayer.frame     = self.bounds;
    self.trackColor       = [UIColor blackColor];
    [self.layer addSublayer:_trackLayer];
}

- (void)addProgressLayer {
    /**
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.frame         = self.bounds;
    progressLayer.fillColor     = [[UIColor clearColor] CGColor];
    progressLayer.strokeColor   = [UIColor redColor].CGColor;
    progressLayer.lineWidth     = PROGRESS_LINE_WIDTH;
    [self.layer addSublayer:progressLayer];
  
    CGPoint center              = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));// 6
    // CGFloat radius = (PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2;
    CGFloat radius = (CGRectGetMidX(self.bounds) - PROGRESS_LINE_WIDTH/2.0);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:degreesToRadians(-90) endAngle:degreesToRadians(0) clockwise:YES];//上面说明过了用来构建圆形
    progressLayer.path =[path CGPath];
     */
    
    self.progressLayer = [CAShapeLayer layer];
    _progressLayer.frame         = self.bounds;
    _progressLayer.fillColor     = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor   = [UIColor redColor].CGColor;
    _progressLayer.lineWidth     = PROGRESS_LINE_WIDTH;
    [self.layer addSublayer:_progressLayer];
}

// 更新track path
- (void)refreshTrack {
    self.trackLayer.path = [self getArcPathWithProgress:1.0].CGPath;
}

// 更新progress path
- (void)refreshProgress {
    self.progressLayer.path = [self getArcPathWithProgress:_progress].CGPath;
    [self moveIndicatorViewWithProgress:_progress];
}

- (void)setTrackColor:(UIColor *)trackColor {
    self.trackLayer.strokeColor = trackColor.CGColor;
}

// 更新线条宽度
- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    self.trackLayer.lineWidth = _progressWidth;
    self.progressLayer.lineWidth = _progressWidth;
    [self refreshTrack];
    [self refreshProgress];
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress > 1.00001 ? 0.0 : progress;
    [self refreshProgress];
}

- (void)setProgress:(CGFloat)progress aminated:(BOOL)animated {}

/**
              | 270
              |
              |
   180 ------------------> 0, 360
              |
              |
              | 90
 
 
              | -90, 270
              |
              |
    ---------------------- 0
    180       |
              |
              | 90
 */

- (UIBezierPath *)getArcPathWithProgress:(CGFloat)progress {
    CGPoint center              = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));// 6
    // CGFloat radius = (PROGREESS_WIDTH-PROGRESS_LINE_WIDTH)/2;
    // CGFloat radius = (CGRectGetMidX(self.bounds) - PROGRESS_LINE_WIDTH/2.0);
    
    // CGFloat radius = (CGRectGetMidX(self.bounds) - self.progressWidth/2.0);
    // UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:2*M_PI*progress-M_PI_2 clockwise:YES];//上面说明过了用来构建圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:R startAngle:-M_PI_2 endAngle:2*M_PI*progress-M_PI_2 clockwise:YES];//上面说明过了用来构建圆形
    return path;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self refreshTrack];
    [self refreshProgress];
}

- (void)setShowProgressIndicator:(BOOL)showProgressIndicator {
    _showProgressIndicator = showProgressIndicator;
    if (_showProgressIndicator) {
        [self addSubview:self.indicatorView];
    } else {
        [_indicatorView removeFromSuperview];
    }
}

- (UIImageView *)indicatorView {
    if (_indicatorView == nil) {
        _indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dot2.png"]];
        _indicatorView.frame = CGRectMake(0, 0, 30, 30);
        [self moveIndicatorViewWithProgress:self.progress];
    }
    return _indicatorView;
}

- (void)moveIndicatorViewWithProgress:(CGFloat)progress {
    double radian = progress * 2 * M_PI - M_PI_2;
    double x = CGRectGetMidX(self.bounds) + cos(-radian) * R;
    double y = CGRectGetMidY(self.bounds) - sin(-radian) * R;
    _indicatorView.center = CGPointMake(x, y);
}

@end

