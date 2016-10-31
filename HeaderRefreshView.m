//
//  HeaderRefreshView.m
//  03-自定义刷新控件的思路
//
//  Created by vera on 16/9/1.
//  Copyright © 2016年 deli. All rights reserved.
//

#import "HeaderRefreshView.h"

@interface HeaderRefreshView ()

@property (nonatomic, weak) UIImageView *arrowImageView;

@property (nonatomic, weak) UILabel *titleLabel;

/**
 *  加载指示器(菊花)
 */
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;

@end

@implementation HeaderRefreshView

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView)
    {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        //当停止刷新就隐藏
        //activityView.hidesWhenStopped
        //修改颜色
        activityView.color = [UIColor greenColor];
        [self addSubview:activityView];
        //启动动画
        //[activityView startAnimating];
        
        _indicatorView = activityView;
    }
    
    return _indicatorView;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        [self addSubview:imageView];
        
        _arrowImageView = imageView;
    }
    
    return _arrowImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        UILabel *l = [[UILabel alloc] init];
        l.text = @"下拉刷新。。。";
        [self addSubview:l];
        
        _titleLabel = l;
    }
    
    return _titleLabel;
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init])
    {
        CGFloat height = 100;
        
        self.frame = CGRectMake(0, -height, scrollView.frame.size.width, height);
        
        [scrollView addSubview:self];
        
        //注册观察者
        /*
         [被观察者的对象 addObserver:观察者 forKeyPath:@"被观察者的属性" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
         */
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

/**
 *  当被观察的属性值改变的时候会自动触发
 *
 *  @param keyPath 观察的属性名字
 *  @param object  观察的对象
 *  @param change  保存修改前后的值
 *  @param context <#context description#>
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    //获取修改后的值
    CGPoint point = [change[NSKeyValueChangeNewKey] CGPointValue];
    
    //NSLog(@"%@值改变了,当前的y=%f",keyPath,point.y);
    NSLog(@"%@",object);
    
    UIScrollView *scrollView = (UIScrollView *)object;
    
    if (point.y <= -70)
    {
        self.titleLabel.text = @"松开刷新。。。";
        
        [UIView animateWithDuration:0.5 animations:^{
            //旋转180度
            self.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        
        
        //停止滑动的时候在判断是否刷新
        //判断是否正在拖拽滚动视图
        if (!scrollView.isDragging)
        {
            /**
             *  <#Description#>
             *
             *  @param UIScrollView <#UIScrollView description#>
             *
             *  @return <#return value description#>
             */
            //停留在临界值
            UIScrollView *scrollView = (UIScrollView *)object;
            //修改内容的inset
            scrollView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
            
            //3秒后还原
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //修改内容的inset
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            });
        }
        
    }
    else
    {
        
        self.titleLabel.text = @"下拉刷新。。。";
        
        [UIView animateWithDuration:0.5 animations:^{
            //还原
            self.arrowImageView.transform = CGAffineTransformIdentity;
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.arrowImageView.frame = CGRectMake(130, 30, 20, 60);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.arrowImageView.frame), 50, 200, 20);
    
    self.indicatorView.frame = CGRectMake(100, 50, 50, 50);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
