//
//  UILabel+WXTextAdView.m
//  WanHuiJiuZhou
//
//  Created by weixuewu on 2020/9/24.
//

#import "UILabel+WXTextAdView.h"

@implementation UILabel (WXTextAdView)

-(id)wx_text{
    return self.text;
}

-(void)setWx_text:(id)wx_text{
    if ([wx_text isKindOfClass:[NSAttributedString class]]) {
        self.attributedText = wx_text;
    }else if ([wx_text isKindOfClass:[NSString class]]){
        self.text = wx_text;
    }
}

@end
