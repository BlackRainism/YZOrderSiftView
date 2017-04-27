//
//  SiftHeaderView.m
//  SAAS
//
//  Created by gushukeji on 2017/4/27.
//  Copyright © 2017年 Rainism-GuShuKeJi. All rights reserved.
//

#import "SiftHeaderView.h"
#import "YZLabel.h"

#define TitleFont [UIFont systemFontOfSize:14]
#define TitleColor [UIColor colorWithHexString:@"7f7f7f"]
#define TextColor [UIColor colorWithHexString:@"333333"]

@interface SiftHeaderView ()

@property(nonatomic,strong)YZLabel *titleLab;

@property(nonatomic,strong)UIImageView *openImgView;

@end

@implementation SiftHeaderView

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.titleLab.text = title;
        [self addSubview:self.titleLab];
        [self addSubview:self.stateLab];
        [self addSubview:self.openImgView];
    }
    return self;
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self addSubview:self.titleLab];
//        [self addSubview:self.stateLab];
//        [self addSubview:self.openImgView];
//    }
//    return self;
//}


#pragma mark - getter and setter

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[YZLabel alloc]initWithFrame:CGRectMake(0, 0, self.width/2, self.height)];
        
        _titleLab.textInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _titleLab.textColor = TitleColor;
        _titleLab.font = TitleFont;
    }
    return _titleLab;
}

-(UILabel *)stateLab{
    if (!_stateLab) {
        _stateLab = [[YZLabel alloc]initWithFrame:CGRectMake(self.width/2, 0, self.width/2 - 30, self.height)];
//        _stateLab.text = @"全部";
        _stateLab.textAlignment = NSTextAlignmentRight;
        _stateLab.textColor = TextColor;
        _stateLab.font = TitleFont;
        
    }
    return _stateLab;
}

-(UIImageView *)openImgView{
    if (!_openImgView) {
        _openImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.stateLab.frame), self.height/2 -10, 20, 20)];
        _openImgView.image = [UIImage imageNamed:@"btn_xiangxia"];
    }
    return _openImgView;
}

-(void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    if (isOpen == 0) {
        self.openImgView.image = [UIImage imageNamed:@"btn_xiangxia"];
    }else{
        self.openImgView.image = [UIImage imageNamed:@"btn_xiangshang"];
    }
}




@end
