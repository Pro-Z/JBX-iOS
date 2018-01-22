//
//  MineOfferListVC.m
//  JBX
//
//  Created by 证 on 2018/1/16.
//  Copyright © 2018年 证. All rights reserved.
//

#import "MineOfferListVC.h"
#import "OfferListCell.h"
#import "OfferListAutoSizeCell.h"
#import "ComSecondVC.h"

@interface MineOfferListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *offerTableView;
@property (nonatomic,assign) NSInteger types;
@end

@implementation MineOfferListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 判断是哪个模块传递的cell
    if (self.pageID == 2 && [self.titleStr isEqualToString:@"待报价"]) {
        self.types = 1;
    }else if(self.pageID == 2 && [self.titleStr isEqualToString:@"已报价"]){
        self.types = 2;
    }else if(self.pageID == 3 && [self.titleStr isEqualToString:@"待报价"]){
        self.types = 3;
    }else if(self.pageID == 3 && [self.titleStr isEqualToString:@"已报价"]){
        self.types = 4;
    }
    DebugLog(@"当前的类型为%ld",_types);
    [self initTableView];
}
- (void) initTableView {
    self.offerTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _offerTableView.backgroundColor = RGBA(236, 238, 241, 1);
    _offerTableView.delegate =self;
    _offerTableView.dataSource = self;
    
    if (_types !=2) {
        [_offerTableView registerClass:[OfferListCell class] forCellReuseIdentifier:@"OfferListCell"];
    }else {
        [_offerTableView registerClass:[OfferListAutoSizeCell class] forCellReuseIdentifier:@"OfferListAutoSizeCell"];
    }
    
    [self.view addSubview:_offerTableView];
    _weekSelf(weakSelf)
    [_offerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
}
#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    
    if (_types != 2) {
        OfferListCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OfferListCell" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        [cell setCellTypeWithNumber:_types];
        if (_types == 1) {
            cell.orderNumberLB.text = @"报价单号: 1232434";
            cell.nameLB.text = @"制单人员: 战三";
            cell.publishTimeLB.text = @"发布时间: 2017-11-20";
        } else if (_types == 3){
            cell.orderNumberLB.text = @"询价单号: 1232434";
            cell.nameLB.text = @"制单人员: 战三";
        } else if (_types == 4){
            cell.orderNumberLB.text = @"询价单号: 1232434";
            cell.nameLB.text = @"制单人员: 战三";
            cell.totalBussnessLB.text = @"有3个商家报价";
        }
        return cell;
    }
    else if(_types == 2){
        OfferListAutoSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OfferListAutoSizeCell" forIndexPath:indexPath];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        cell.orderNumberLB.text = @"报价单号: 123242342";
        cell.nameLB.text = @"制单人员: 战三";
        cell.publishTimeLB.text = @"发布时间: 2017-11-20";
        cell.orderTimeLB.text = @"报价时间：2017-11-22";
        cell.totalMonryLB.text = @"总金额(元)：";
        cell.priceLB.text = @"2500";
        cell.remarkLB.text = @"备注信息：备注信息备注信息备注信息备注信息备注信息备备注信息备注信息备注信息备注信息备注信息备注信息备注信息备备注信息备注信息";
        return cell;
        
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_types == 4) {
        ComSecondVC *comSecondVC = [ComSecondVC new];
        comSecondVC.currentPage = _types;
        comSecondVC.currentTitle = @"商家报价";
        [self.navigationController pushViewController:comSecondVC animated:YES];
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_types == 1) {
        return 110;
    }else if(_types == 2){
        return [_offerTableView fd_heightForCellWithIdentifier:@"OfferListAutoSizeCell" cacheByIndexPath:indexPath configuration:^(OfferListAutoSizeCell *cell) {
            cell.orderNumberLB.text = @"报价单号: 123242342";
            cell.nameLB.text = @"制单人员: 战三";
            cell.publishTimeLB.text = @"发布时间: 2017-11-20";
            cell.orderTimeLB.text = @"报价时间：2017-11-22";
            cell.totalMonryLB.text = @"总金额(元)：";
            cell.priceLB.text = @"2500";
            cell.remarkLB.text = @"备注信息：备注信息备注信息备注信息备注信息备注信息备备注信息备注信息备注信息备注信息备注信息备注信息备注信息备备注信息备注信息";
        }];
    }else if(_types == 3){
        return 72;
    }else if(_types == 4){
        return 100;
    }
    
    return 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
