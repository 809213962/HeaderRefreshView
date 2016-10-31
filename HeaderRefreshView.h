//
//  HeaderRefreshView.h
//  03-自定义刷新控件的思路
//
//  Created by vera on 16/9/1.
//  Copyright © 2016年 deli. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
1.刷新控件添加到哪：添加滚动视图上
2.侦听y偏移量
3.停留contentInset
 */
@interface HeaderRefreshView : UIView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end
