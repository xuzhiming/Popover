//
//  PopShadowView.m
//  AliyunOSSiOS
//
//  Created by xzming on 2018/11/9.
//

#import "PopShadowView.h"

@implementation PopShadowView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
    if (self.onTouchShadow) {
        self.onTouchShadow();
    }
}

@end
