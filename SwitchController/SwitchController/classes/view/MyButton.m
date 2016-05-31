//
//  MyButton.m
//  SwitchController
//
//  Created by fangjs on 16/5/31.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

   CGPoint imageBtnP = [self convertPoint:point toView:self.imageButton];
    
    if ([self.imageButton pointInside:imageBtnP withEvent:event]) {
        return self.imageButton;
    }else {
        return [super hitTest:point withEvent:event];
    }
    
}



- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    //获取当前点
    CGPoint curP = [touch locationInView:self];
    
    //获取上一次的点
    CGPoint preP = [touch previousLocationInView:self];
    
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    
    CGPoint center = self.center;
    
    center.x += offsetX;
    center.y += offsetY;
    
    self.center = center;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
