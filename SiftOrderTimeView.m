//
//  SiftOrderTimeView.m
//  SAAS
//
//  Created by gushukeji on 2017/4/27.
//  Copyright © 2017年 Rainism-GuShuKeJi. All rights reserved.
//

#import "SiftOrderTimeView.h"
#import "YZLabel.h"



#define TitleFont [UIFont systemFontOfSize:14]
#define TitleColor [UIColor colorWithHexString:@"7f7f7f"]
#define TextColor [UIColor colorWithHexString:@"333333"]

@interface SiftOrderTimeView ()<IQActionSheetPickerViewDelegate>


@property(nonatomic,strong)YZLabel *titleLab;

@property(nonatomic,strong)UILabel *padingLab;



@end


@implementation SiftOrderTimeView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self addSubview:self.titleLab];
        [self addSubview:self.startTimeBtn];
        [self addSubview:self.padingLab];
        [self addSubview:self.endTimeBtn];
    }
    return self;
}

#pragma mark - events response

-(void)startTimeBtnClick{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:nil delegate:self];
    picker.tag = 1;
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];
    
}

-(void)endTimeBtnClick{
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:nil delegate:self];
    picker.tag = 2;
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];
}

#pragma mark - IQActionSheetPickerView Delegate

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate *)date{
    if (pickerView.tag == 1) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        [self.startTimeBtn setTitle:[formatter stringFromDate:date] forState:UIControlStateNormal];
        NSLog(@"%@",[formatter stringFromDate:date]);
    }else if (pickerView.tag ==2){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        [self.endTimeBtn setTitle:[formatter stringFromDate:date] forState:UIControlStateNormal];
        NSLog(@"%@",[formatter stringFromDate:date]);
    }
}


#pragma mark - getter and setter

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[YZLabel alloc]initWithFrame:CGRectMake(0, 0, self.width/2, self.height)];
        _titleLab.textInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _titleLab.text = @"订单时间";
        _titleLab.textColor = TitleColor;
        _titleLab.font = TitleFont;
    }
    return _titleLab;
}

-(UIButton *)startTimeBtn{
    if (!_startTimeBtn) {
        _startTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2 + 5, 10, (self.width/2 - 15)/2, 24)];
        _startTimeBtn.titleLabel.font = TitleFont;
        [_startTimeBtn setTitleColor:TextColor forState:UIControlStateNormal];
        _startTimeBtn.layer.borderColor = TitleColor.CGColor;
        _startTimeBtn.layer.borderWidth = 1;
        _startTimeBtn.layer.cornerRadius = 2;
        [_startTimeBtn addTarget:self action:@selector(startTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _startTimeBtn;
}
-(UILabel *)padingLab{
    if (!_padingLab ) {
        _padingLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.startTimeBtn.frame), 0, 5, self.height)];
        _padingLab.text = @"-";
        _padingLab.textColor = TitleColor;
    }
    return _padingLab;
}

-(UIButton *)endTimeBtn{
    if (!_endTimeBtn) {
        _endTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.padingLab.frame), 10, (self.width/2 - 15)/2, 24)];
        _endTimeBtn.titleLabel.font = TitleFont;
        [_endTimeBtn setTitleColor:TextColor forState:UIControlStateNormal];
        _endTimeBtn.layer.borderColor = TitleColor.CGColor;
        _endTimeBtn.layer.borderWidth = 1;
        _endTimeBtn.layer.cornerRadius = 2;
        [_endTimeBtn addTarget:self action:@selector(endTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _endTimeBtn;
}

@end
