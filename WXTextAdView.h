//
//  WXTextAdView.h
//  WanHuiJiuZhou
//
//  Created by weixuewu on 2020/9/24.
//  文字条上下翻动

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WXTextAdView : UIView

///数据源
@property (nonatomic, strong) NSArray *textArray;

///文字停留时间，默认3s
@property (nonatomic, assign) NSTimeInterval textStayTime;

///动画时间，默认1s
@property (nonatomic, assign) NSTimeInterval animationTime;

///内边距, 默认15
@property (nonatomic, assign) NSInteger margin;

@property (nonatomic, strong)   UIFont  * textFont;
@property (nonatomic, strong)   UIColor * textColor;
@property (nonatomic, assign)   NSTextAlignment textAlignment;

-(void)startWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
