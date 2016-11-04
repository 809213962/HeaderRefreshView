//
//  HeaderRefreshView.h
//
//  Created by lin on 16/10/10.
//  Copyright © 2016年 林理刚. All rights reserved.
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
