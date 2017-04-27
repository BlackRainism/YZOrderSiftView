//
//  SiftHeaderView.h
//  SAAS
//
//  Created by gushukeji on 2017/4/27.
//  Copyright © 2017年 Rainism-GuShuKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiftHeaderView : UIView

@property(nonatomic,strong)UILabel *stateLab;
@property(nonatomic,assign)BOOL isOpen;


-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

@end
