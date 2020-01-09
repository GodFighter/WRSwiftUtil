//
//  UIControl+WRBlock.h
//  WRSwiftUtilDemo
//
//  Created by xianghui-iMac on 2020/1/10.
//  Copyright © 2020 xianghui. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (WRBlock)

- (void)wr_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END
