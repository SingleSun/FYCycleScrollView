//
//  FYScrollView.h
//  FYCycleScrollviewExample
//
//  Created by 樊杨 on 2019/11/25.
//  Copyright © 2019 樊杨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYScrollView : UIView

/**加载本地图片*/
@property(nonatomic,strong)NSArray * localImages;
/**加载网络图片*/
@property(nonatomic,strong)NSArray * imagesUrl;



@end

NS_ASSUME_NONNULL_END
