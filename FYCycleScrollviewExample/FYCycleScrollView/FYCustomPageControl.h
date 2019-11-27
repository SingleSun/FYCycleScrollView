//
//  FYCustomPageControl.h
//  FYCycleScrollviewExample
//
//  Created by 樊杨 on 2019/11/27.
//  Copyright © 2019 樊杨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    FYPageControlModeDefault,
    FYPageControlModeCustom,
} FYPageControlMode;

@interface FYCustomPageControl : UIPageControl
//圆点大小
@property(nonatomic,assign)CGFloat raduis;
/// 自定义pagecontrolz选中图片
@property(nonatomic,strong)UIImage * currentPageImg;
/// 自定义pagecontrolz正常图片
@property(nonatomic,strong)UIImage * pageImg;

/// pageControl类型(默认系统样式)
@property(nonatomic,assign)FYPageControlMode pageMode;


@end

NS_ASSUME_NONNULL_END
