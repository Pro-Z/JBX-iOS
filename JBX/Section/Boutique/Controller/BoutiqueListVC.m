//
//  BoutiqueListVC.m
//  JBX
//
//  Created by 证 on 2018/1/18.
//  Copyright © 2018年 证. All rights reserved.
//

#import "BoutiqueListVC.h"
#import "BoutiqueCell.h"
#import "ItemModel.h"
@interface BoutiqueListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) UICollectionView *boutiqueCollectionView;
@property (nonatomic,strong) NSArray *picArr;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation BoutiqueListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WHITE_BG
    [self initDataSource];
    [self initCollectionView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.boutiqueCollectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
}


- (void) initDataSource {
    self.picArr = @[
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276552636&di=07b1d664a8f47fc1d346d4455763aebb&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F08f790529822720ef2a7e06771cb0a46f31fabc6.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516871674&di=dbe76b3a7a11a2d7adc08171bf673375&imgtype=jpg&er=1&src=http%3A%2F%2Fb.zol-img.com.cn%2Fsjbizhi%2Fimages%2F7%2F320x510%2F1415695092182.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276972041&di=5e2c83732978db5f4b77d77340579b8a&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D1108480664%2C391981744%26fm%3D214%26gp%3D0.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276553031&di=d48ac6c496cbeb1fd66022fd82fa9383&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F8601a18b87d6277f3dc16e2a22381f30e824fcd5.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276553031&di=3ae55e16c239c74aa68d6417cd8549fc&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01fa9e57c515e70000018c1b3e17c4.jpg%401280w_1l_2o_100sh.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276553031&di=d7a8b690d53eb0a350e03136df049cdf&imgtype=0&src=http%3A%2F%2Fwww.ecorr.org%2Fuploads%2Fallimg%2F2015%2F12%2F21%2F58-151221092344495.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276553029&di=ef2bab9d7a26f08f2f8687f6ddb06a43&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0104c259ae69a1a8012028a9305fb9.jpg%402o.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276553028&di=8cb8dec7ccbe04111213f47056aff7bb&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D288378cd376d55fbd1cb7e65054b253f%2Fb3fb43166d224f4a2eb0670003f790529822d1f3.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276693217&di=32bf99b65d8d4ae078c24e958082eb97&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dpixel_huitu%252C0%252C0%252C294%252C40%2Fsign%3D838705fa3187e950561afb2c7940362f%2F3801213fb80e7bec616009d8242eb9389b506b54.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276693217&di=6a96b5ee489a6045d4d4bf8dc31178ba&imgtype=0&src=http%3A%2F%2Fimage.cn.made-in-china.com%2Fprod%2F000-KEytzMnIbubh.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276693216&di=cb9f2f52a00933528a1a32e52bdca367&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fdcc451da81cb39dbcc90077fdb160924ab183042.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276733545&di=1fd714102515232105833ff6c69d81b2&imgtype=0&src=http%3A%2F%2Fimg000.hc360.cn%2Fhb%2FMTQ3MTQyMzM1NzgwNjE4Mzg2OTkxNzE%3D.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276795259&di=a25e3955fe6e704541faf8f35d231193&imgtype=0&src=http%3A%2F%2Fwww.jdzj.com%2FUserDocument%2F2012Y%2Fdgxybxg%2FPicture%2F201341483122.jpg",
                        
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516276956551&di=2b22a48af81000d2ccea3ccb772e4bf8&imgtype=0&src=http%3A%2F%2Fimg5.niutuku.com%2Fphone%2F1212%2F5952%2F5952-niutuku.com-89417.jpg",
                    

                        ];
    
    self.dataSource = [NSMutableArray array];
    for (NSString *item in _picArr) {
        ItemModel *model = [ItemModel new];
        model.imageUrl = item;
        [self.dataSource addObject:model];
    }
    
    
   
}


- (void) initCollectionView{
    
    CHTCollectionViewWaterfallLayout *flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [flowLayout setColumnCount:2];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setScrollDirection:(UICollectionViewScrollDirectionVertical)];
    self.boutiqueCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _boutiqueCollectionView.backgroundColor = [UIColor whiteColor];
    _boutiqueCollectionView.delegate = self;
    _boutiqueCollectionView.dataSource = self;
    [_boutiqueCollectionView registerClass:[BoutiqueCell class] forCellWithReuseIdentifier:@"BoutiqueCell"];
    [self.view addSubview:_boutiqueCollectionView];
    _weekSelf(weakSelf)
    [_boutiqueCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(10);
        make.left.equalTo(weakSelf.view).offset(0);
        make.right.equalTo(weakSelf.view).offset(0);
        make.bottom.equalTo(weakSelf.view).offset(-48);
    }];
    
    
}
#pragma mark -- collectionView dataSource

/** 每组cell的个数*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSource.count;
}

/** cell的内容*/
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BoutiqueCell *cell = nil;
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoutiqueCell" forIndexPath:indexPath];
    cell.backgroundColor = RGBA(246, 246, 246, 1);
    
    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString *imgUrlString = model.imageUrl;
    
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:imgUrlString] placeholderImage:[UIImage imageNamed:@"placerholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            if (!CGSizeEqualToSize(model.imageSize, image.size)) {
                model.imageSize = image.size;
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
        }
    }];
    
    
    return cell;
}

/** 总共多少组*/
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/** 头部/底部*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
    
    //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    //        // 头部
    //        WWCollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"header"   forIndexPath:indexPath];
    //        view.headerLabel.text = [NSString stringWithFormat:@"头部 - %zd",indexPath.section];
    //        return view;
    //
    //    }else {
    //        // 底部
    //        WWCollectionFooterReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:@"footer"   forIndexPath:indexPath];
    //        view.footerLabel.text = [NSString stringWithFormat:@"底部 - %zd",indexPath.section];
    //        return view;
    //    }
}

#pragma mark -- UICollectionViewDelegateFlowLayout
/** 每个cell的尺寸*/
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(80, 75);
//}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (!CGSizeEqualToSize(model.imageSize, CGSizeZero)) {
        return model.imageSize;
    }
    return CGSizeMake(150, 150);
}


///** 头部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 40);
//}
//
///** 顶部的尺寸*/
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//
//
//    return CGSizeMake(self.view.bounds.size.width, 40);
//}

/** section的margin*/
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 0, 10, 0);
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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
