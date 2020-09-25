//
//  UIView+WXTextAdView.m
//  WanHuiJiuZhou
//
//  Created by weixuewu on 2020/9/24.
//

#import "UIView+WXTextAdView.h"

@implementation UIView (WXTextAdView)

// getter
-(CGFloat)wx_top{
    return self.frame.origin.y;
}

-(CGFloat)wx_right{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)wx_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)wx_left{
    return self.frame.origin.x;
}

-(CGFloat)wx_width{
    return self.frame.size.width;
}

-(CGFloat)wx_height{
    return self.frame.size.height;
}

// setter
-(void)setWx_top:(CGFloat)wx_top{
    CGRect frame = self.frame;
    frame.origin.y = wx_top;
    self.frame = frame;
}

-(void)setWx_right:(CGFloat)wx_right{
    CGRect frame = self.frame;
    frame.origin.x = wx_right - frame.size.width;
    self.frame = frame;
}

-(void)setWx_bottom:(CGFloat)wx_bottom{
    CGRect frame = self.frame;
    frame.origin.y = wx_bottom - frame.size.height;
    self.frame = frame;
}

-(void)setWx_left:(CGFloat)wx_left{
    CGRect frame = self.frame;
    frame.origin.x = wx_left;
    self.frame = frame;
}

-(void)setWx_width:(CGFloat)wx_width{
    CGRect frame = self.frame;
    frame.size.width = wx_width;
    self.frame = frame;
}

-(void)setWx_height:(CGFloat)wx_height{
    CGRect frame = self.frame;
    frame.size.height = wx_height;
    self.frame = frame;
}


@end
