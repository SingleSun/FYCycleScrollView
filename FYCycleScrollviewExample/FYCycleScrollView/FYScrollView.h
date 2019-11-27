//
//  FYScrollView.h
//  FYCycleScrollviewExample
//
//  Created by 樊杨 on 2019/11/25.
//  Copyright © 2019 樊杨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYCustomPageControl.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CycleScrollViewClickBlock)(NSInteger index);

@interface FYScrollView : UIView

/**加载本地图片*/
@property(nonatomic,strong)NSArray * localImages;
/**加载网络图片*/
@property(nonatomic,strong)NSArray * imagesUrl;

@property(nonatomic,copy)CycleScrollViewClickBlock cycleScrollViewClick;

/// 设置小白点大小
@property(nonatomic,assign)CGFloat raduis;
/// 小白点样式
@property(nonatomic,assign)FYPageControlMode pageControlMode;
/// 选中小白点颜色
@property(nonatomic,strong)UIColor *currentColor;
/// 未选中小白点颜色
@property(nonatomic,strong)UIColor *normalColor;

/// 选中小白点图片
@property(nonatomic,strong)UIImage *currentImage;
/// 未选中小白点图片
@property(nonatomic,strong)UIImage *normalImage;

@end

NS_ASSUME_NONNULL_END
