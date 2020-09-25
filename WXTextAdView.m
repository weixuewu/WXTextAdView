//
//  WXTextAdView.m
//  WanHuiJiuZhou
//
//  Created by weixuewu on 2020/9/24.
//

#import "WXTextAdView.h"
#import "UILabel+WXTextAdView.h"
#import "UIView+WXTextAdView.h"

@interface WXTextAdView ()

@property (nonatomic, strong) UILabel *currentTextLabel;    //当前label
@property (nonatomic, strong) UILabel *stayTextLabel;       //等待label
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL needStop;
@property (nonatomic, assign) BOOL isRunning;

@end

@implementation WXTextAdView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor brownColor];
    
    self.clipsToBounds = YES;
    
    self.index = 0;
    self.textStayTime = 3.0;
    self.animationTime = 1.0;
    self.margin = 15;
    self.textArray = @[];
    
    self.textFont = [UIFont systemFontOfSize:12.0];
    self.textColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentLeft;
}

-(void)startWithArray:(NSArray *)array{
    
    if (array.count == 0) {
        [self removeFromSuperview];
        return;
    }
    
    self.textArray = array;
    
    self.currentTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.margin, self.margin, self.wx_width - 2*self.margin, self.wx_height - 2*self.margin)];
    self.currentTextLabel.backgroundColor = [UIColor grayColor];
    self.currentTextLabel.font = self.textFont;
    self.currentTextLabel.textColor = self.textColor;
    self.currentTextLabel.textAlignment = self.textAlignment;
    [self addSubview:self.currentTextLabel];
    
    //当前页面
    self.currentTextLabel.wx_text = self.textArray[self.index];
    
    //若数据大于一条，则创建预备等待label
    if (array.count > 1) {
        self.stayTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.margin, -self.wx_height, self.wx_width - 2*self.margin, self.wx_height - 2*self.margin)];
        self.stayTextLabel.backgroundColor = [UIColor greenColor];
        self.stayTextLabel.font = self.textFont;
        self.stayTextLabel.textColor = self.textColor;
        self.stayTextLabel.textAlignment = self.textAlignment;
        [self addSubview:self.stayTextLabel];
    }
    
    [self scrollTextLabel:array];
}

-(void)scrollTextLabel:(NSArray *)array{
    //非当前页面，延迟尝试
    if (![self isCurrentViewControllerVisible:[self viewController]]) {
        [self performSelector:@selector(scrollTextLabel:) withObject:array afterDelay:1.0];
    }else{
        //当前页面
        
        //当数组为1时，不用走下面动画流程，直接消失即可
        if (array.count == 1) {
            [self performSelector:@selector(removeView) withObject:nil afterDelay:self.textStayTime];
        }else{
            self.stayTextLabel.wx_text  = self.textArray[[self nextIndex:self.index]];
            self.stayTextLabel.frame = CGRectMake(self.margin, self.wx_height, self.stayTextLabel.wx_width, self.stayTextLabel.wx_height);
                    
            [UIView animateWithDuration:_animationTime delay:_textStayTime options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                self.currentTextLabel.frame = CGRectMake(self.margin, -self.wx_height, self.currentTextLabel.wx_width, self.currentTextLabel.wx_height);
                self.stayTextLabel.frame = CGRectMake(self.margin, self.margin, self.stayTextLabel.wx_width, self.stayTextLabel.wx_height);
                
            } completion:^(BOOL finished) {
                
                self.index = [self nextIndex:self.index];
                
                UILabel * temp = self.currentTextLabel;
                self.currentTextLabel = self.stayTextLabel;
                self.stayTextLabel = temp;
                
                //展示完后，停留一会儿自动删除self
                if (self.needStop) {
                    [self performSelector:@selector(removeView) withObject:nil afterDelay:self.textStayTime];
                }else{
                    [self performSelector:@selector(scrollTextLabel:) withObject:array];
                }
            }];
        }
    }
}

-(NSInteger)nextIndex:(NSInteger)index{
    NSInteger nextIndex = index + 1;
    if (nextIndex >= self.textArray.count) {
        nextIndex = 0;
        self.needStop = YES;
    }
    return nextIndex;
}

-(void)removeView{
    [UIView animateWithDuration:self.animationTime animations:^{
        
        self.wx_top = -self.wx_height;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - State Check
-(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController{
    return (viewController.isViewLoaded && viewController.view.window && [UIApplication sharedApplication].applicationState == UIApplicationStateActive);
}

- (UIViewController *)viewController {
    for (UIView * next = [self superview]; next; next = next.superview) {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
