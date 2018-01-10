//
//  HotTVC.m
//  JBX
//
//  Created by 证 on 2018/1/10.
//  Copyright © 2018年 证. All rights reserved.
//

#import "HotTVC.h"
#import "JobCell.h"
#import "DetailVC.h"

@interface HotTVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *hotTabview;
@end

@implementation HotTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initHotTableView];
}
- (void) initHotTableView {
    self.hotTabview = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _hotTabview.delegate = self;
    _hotTabview.dataSource = self;
    [self.view addSubview:_hotTabview];
    _weekSelf(weakSelf)
    [_hotTabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark mark  - uitableview 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    static NSString *rid=@"JobCell";
    JobCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell==nil){
        cell=[[JobCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        [cell setSelectionStyle:(UITableViewCellSelectionStyleNone)];
        
        cell.nameLab.text = @"测试名字";
        cell.timeLab.text = @"一小时前";
        cell.priceLab.text = @"6000/月";
        cell.expericeLab.text = @"十年以及十年以上经验";
        cell.applyBtn.titleLabel.text = @"申请";
        cell.commitLab.text = @"评价:一句话评价自己";
        cell.companyLab.text = @"天津金利恒有限公司";
        
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailVC *detailVC = [DetailVC new];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
