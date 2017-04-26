//
//  OrderSiftSelectView.h
//  SAAS
//
//  Created by BlackRainism on 2017/4/26.
//  Copyright © 2017年 Rainism-BlackRainism. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderSiftSelectViewDelegate <NSObject>

-(void)dismissOrderSiftView;

@end

@interface OrderSiftSelectView : UIView

@property(nonatomic,weak)id<OrderSiftSelectViewDelegate>delegate;

-(void)show;
-(void)hide;

@end
