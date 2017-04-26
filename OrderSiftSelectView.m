//
//  OrderSiftSelectView.m
//  SAAS
//
//  Created by BlackRainism on 2017/4/26.
//  Copyright © 2017年 Rainism-BlackRainism. All rights reserved.
//

#import "OrderSiftSelectView.h"
#import "YZLabel.h"


#define ContentViewWidth  (self.width*2)/3
#define ShadowWidth (self.width)/3

#define TitleFont [UIFont systemFontOfSize:14]
#define TitleColor [UIColor colorWithHexString:@"7f7f7f"]
#define TextColor [UIColor colorWithHexString:@"333333"]

@interface OrderSiftSelectView ()<UITableViewDelegate,UITableViewDataSource>

//筛选标题
@property(nonatomic,strong)YZLabel *titleLab;

@property(nonatomic,strong)UIView *shadowView;

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,strong)NSArray<NSString *>*orderStateArr;
@property(nonatomic,strong)NSArray<NSString *>*payStateArr;

@end

static NSString *defaultCell = @"UITableViewCell";
@implementation OrderSiftSelectView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _orderStateArr = @[@"全部",@"待发货确认",@"待收货确认",@"待财务审核",@"已完成",@"已关闭",@"订单作废",@"待订单审核",@"待出库审核"];
        _payStateArr = @[@"全部",@"未付款",@"部分付款",@"全部付款",@"已取消"];
        [self addSubview:self.contentView];
        [self addSubview:self.shadowView];
        [self.contentView addSubview:self.tableView];
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

#pragma mark - public methonds 

-(void)show{
    _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [UIView animateWithDuration:0.25 animations:^{
    } completion:^(BOOL finished) {
        CGRect frame =self.frame;
        frame.origin.x = 0;
        self.frame = frame;
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)hide{
    _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = SCREENWIDTH;
        self.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.orderStateArr.count;
    }
    return self.payStateArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCell];
    }
    cell.contentView.layoutMargins = UIEdgeInsetsMake(5, 5, 5, 5);
    cell.contentView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    cell.textLabel.font = TitleFont;
    cell.textLabel.textColor = TextColor;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.orderStateArr[indexPath.row];
    }else{
        cell.textLabel.text = self.payStateArr[indexPath.row];
    }
    return cell;
}


#pragma mark - event response
//点击蒙版
-(void)shadowViewClick
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(dismissOrderSiftView)]) {
        [_delegate dismissOrderSiftView];
    }
}



#pragma mark - getter and setters

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(ShadowWidth, 0, ContentViewWidth, self.height)];
        _contentView.backgroundColor = UIColor.whiteColor;
    }
    return _contentView;
}

-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [[UIView alloc]init];
        _shadowView.frame = CGRectMake(0, 0, ShadowWidth, self.height);
        _shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shadowViewClick)];
        _shadowView.userInteractionEnabled = YES;
        [_shadowView addGestureRecognizer:singleTap];
    }
    return _shadowView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[YZLabel alloc]initWithFrame:CGRectMake(0, 0, ContentViewWidth, 30)];
        _titleLab.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _titleLab.textInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        _titleLab.text = @"筛选";
        _titleLab.textColor = TitleColor;
        _titleLab.font = TitleFont;
        
    }
    return _titleLab;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, ContentViewWidth, self.height - 30) style:UITableViewStylePlain];
        
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}


@end
