//
//  ZZCircleProgressView.h
//  ZZCircleProgressView
//
//  Created by 刘威振 on 12/22/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCircleProgressView : UIView

/**
 *  线条宽
 */
@property (nonatomic) CGFloat progressWidth;

/**
 *  进度条的未渲染颜色
 */
@property (nonatomic) UIColor *trackColor;

/**
 *  进度条的渲染色
 */
@property (nonatomic) UIColor *progressColor;

/**
 *  进度 [0.0 ~ 1.0]
 */
@property (nonatomic) CGFloat progress;

/**
 *  是否显示小圆点
 */
@property (nonatomic, getter=isShowProgressIndicator) BOOL showProgressIndicator;

- (void)setProgress:(CGFloat)progress aminated:(BOOL)animated;

@end
