//
//  OrderSiftSelectView.m
//  SAAS
//
//  Created by BlackRainism on 2017/4/26.
//  Copyright © 2017年 Rainism-BlackRainism. All rights reserved.
//

#import "OrderSiftSelectView.h"
#import "YZLabel.h"
#import "SiftHeaderView.h"
#import "SiftOrderTimeView.h"


#define ContentViewWidth  (self.width*2)/3
#define ShadowWidth (self.width)/3

#define TitleFont [UIFont systemFontOfSize:14]
#define TitleColor [UIColor colorWithHexString:@"7f7f7f"]
#define TextColor [UIColor colorWithHexString:@"333333"]

@interface OrderSiftSelectView ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)YZLabel *titleLab;//筛选标题

@property(nonatomic,strong)UIView *shadowView;//蒙版

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *resetBtn; //重置
@property(nonatomic,strong)UIButton *okBtn; //确认

@property(nonatomic,strong)NSArray<NSString *>*orderStateArr;
@property(nonatomic,strong)NSArray<NSString *>*payStateArr;

@property(nonatomic,assign)BOOL isFirstOpen;
@property(nonatomic,assign)BOOL isTwoOpen;

@property(nonatomic,assign)NSInteger orderIndex; //记录订单点击index
@property(nonatomic,assign)NSInteger payIndex; //记录付款点击index


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
        [self.contentView addSubview:self.resetBtn];
        [self.contentView addSubview:self.okBtn];
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
    UIViewController *topController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [topController.view addSubview:self];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.isFirstOpen == NO) {
            return 0;
        }else{
            return self.orderStateArr.count;
        }
        
    }else if(section == 1){
        if (self.isTwoOpen == NO) {
            return 0;
        }else{
            return self.payStateArr.count;
        }
    }else{
        return 0;
    }
    
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        SiftHeaderView *headerOne;
        if (!headerOne) {
            headerOne = [[SiftHeaderView alloc]initWithFrame:CGRectMake(0, 0, ContentViewWidth, 44) andTitle:@"订单状态"];
            headerOne.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerOneTap)];
            [headerOne addGestureRecognizer:tapOne];
        }
        headerOne.stateLab.text = self.orderStateArr[self.orderIndex];
        return headerOne;
    }else if(section == 1){
        SiftHeaderView *headerTwo ;
        if (!headerTwo) {
            headerTwo = [[SiftHeaderView alloc]initWithFrame:CGRectMake(0, 0, ContentViewWidth, 44) andTitle:@"支付状态"];
            headerTwo.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTwoTap)];
            [headerTwo addGestureRecognizer:tapTwo];
        }
        headerTwo.stateLab.text = self.payStateArr[self.payIndex];
        return headerTwo;
    }else{
        SiftOrderTimeView *headerThree;
        if (!headerThree) {
            headerThree = [[SiftOrderTimeView alloc]initWithFrame:CGRectMake(0, 0, ContentViewWidth, 44)];
        }
        return headerThree;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    if (indexPath.section == 0) {
        self.orderIndex = indexPath.row;
        self.isFirstOpen = NO;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        self.payIndex = indexPath.row;
        self.isTwoOpen = NO;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}






#pragma mark - event response
//点击蒙版
-(void)shadowViewClick
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(dismissOrderSiftView)]) {
        [_delegate dismissOrderSiftView];
    }
}

#pragma mark - private methonds

-(void)headerOneTap{
    self.isFirstOpen =!self.isFirstOpen;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)headerTwoTap{
    self.isTwoOpen = !self.isTwoOpen;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
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
        _titleLab = [[YZLabel alloc]initWithFrame:CGRectMake(0, 0, ContentViewWidth, 40)];
        _titleLab.backgroundColor = UIColor.groupTableViewBackgroundColor;
        _titleLab.textInsets = UIEdgeInsetsMake(10, 15, 0, 0);
        _titleLab.text = @"筛选";
        _titleLab.textColor = TitleColor;
        _titleLab.font = TitleFont;
        
    }
    return _titleLab;
}

-(UIButton *)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height - 40, ContentViewWidth/2, 40)];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_resetBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _resetBtn.backgroundColor = UIColor.whiteColor;
    }
    return _resetBtn;
}

-(UIButton *)okBtn{
    if (!_okBtn ) {
        _okBtn = [[UIButton alloc]initWithFrame:CGRectMake(ContentViewWidth/2, self.height - 40, ContentViewWidth/2, 40)];
        [_okBtn setTitle:@"确认" forState:UIControlStateNormal];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_okBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _okBtn.backgroundColor = [UIColor colorWithHexString:@"ff6243"];
    }
    return _okBtn;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, ContentViewWidth, self.height - 80) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.sectionFooterHeight = 0;
        _tableView.bounces = NO;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}


@end
