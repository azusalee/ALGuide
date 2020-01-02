//
//  ALGuideView.h
//  ALGuide
//
//  Created by lizihong on 2020/1/2.
//  Copyright © 2020 AL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALGuideView : UIView

/// 添加镂空区域
- (void)addThroughFrame:(CGRect)frame;
/// 移除所有镂空区域
- (void)removeAllThroughFrame;

@end

NS_ASSUME_NONNULL_END
