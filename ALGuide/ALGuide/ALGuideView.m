//
//  ALGuideView.m
//  ALGuide
//
//  Created by lizihong on 2020/1/2.
//  Copyright © 2020 AL. All rights reserved.
//

#import "ALGuideView.h"
#import "ALThroughCircle.h"

@interface ALGuideView()

@property (nonatomic, strong) NSMutableArray *throughFrameArray;
@property (nonatomic, strong) NSMutableArray<ALThroughCircle*> *throughCircleArray;

@end

@implementation ALGuideView

- (NSMutableArray *)throughFrameArray{
    if (_throughFrameArray == nil) {
        _throughFrameArray = [[NSMutableArray alloc] init];
    }
    return _throughFrameArray;
}

- (NSMutableArray *)throughCircleArray{
    if (_throughCircleArray == nil) {
        _throughCircleArray = [[NSMutableArray alloc] init];
    }
    return _throughCircleArray;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        for (NSValue *throughValue in self.throughFrameArray) {
            if (CGRectContainsPoint([throughValue CGRectValue], point)) {
                return nil;
            }
        }
        CGFloat x;
        CGFloat y;
        for (ALThroughCircle *circle in self.throughCircleArray) {
            x = point.x-circle.center.x;
            y = point.y-circle.center.y;
            if (x*x+y*y < circle.radius*circle.radius) {
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

- (void)addThroughCircle:(CGPoint)center radius:(CGFloat)radius {
    ALThroughCircle *circle = [[ALThroughCircle alloc] init];
    circle.center = center;
    circle.radius = radius;
    [self.throughCircleArray addObject:circle];
    [self setNeedsLayout];
}

- (void)removeAllThrough{
    [self.throughFrameArray removeAllObjects];
    [self.throughCircleArray removeAllObjects];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRect:self.bounds];
    for (NSValue *throughValue in self.throughFrameArray) {
        [bpath appendPath:[[UIBezierPath bezierPathWithRect:[throughValue CGRectValue]] bezierPathByReversingPath]];
    }
    for (ALThroughCircle *circle in self.throughCircleArray) {
        [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:circle.center radius:circle.radius startAngle:0 endAngle:2*M_PI clockwise:NO]];
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
