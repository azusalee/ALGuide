//
//  ALGuideView.m
//  ALGuide
//
//  Created by lizihong on 2020/1/2.
//  Copyright © 2020 AL. All rights reserved.
//

#import "ALGuideView.h"

@interface ALGuideView()

@property (nonatomic, strong) NSMutableArray *throughFrameArray;

@end

@implementation ALGuideView

- (NSMutableArray *)throughFrameArray{
    if (_throughFrameArray == nil) {
        _throughFrameArray = [[NSMutableArray alloc] init];
    }
    return _throughFrameArray;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        for (NSValue *throughValue in self.throughFrameArray) {
            if (CGRectContainsPoint([throughValue CGRectValue], point)) {
                return nil;
            }
        }
    }
    return hitView;
}

- (void)addThroughFrame:(CGRect)frame{
    [self.throughFrameArray addObject:[NSValue valueWithCGRect:frame]];
    [self setNeedsLayout];
}

- (void)removeAllThroughFrame{
    [self.throughFrameArray removeAllObjects];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:self.bounds];
    for (NSValue *throughValue in self.throughFrameArray) {
        [bpath appendPath:[[UIBezierPath bezierPathWithRect:[throughValue CGRectValue]] bezierPathByReversingPath]];
    }
    //创建一个CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;
    
    //添加图层蒙板
    self.layer.mask = shapeLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
