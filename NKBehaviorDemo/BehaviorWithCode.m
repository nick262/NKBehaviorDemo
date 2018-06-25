//
//  BehaviorWithCode.m
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/25.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "BehaviorWithCode.h"
#import "NKNavBarGradientBehavior.h"
#import "NKParallaxHeaderBehavior.h"
#import "NKMultipleProxyBehavior.h"

@interface BehaviorWithCode ()

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NKParallaxHeaderBehavior *parallaxBehavior;
@property (nonatomic,strong) NKNavBarGradientBehavior *navBarBehavior;
@property (nonatomic,strong) NKMultipleProxyBehavior *behaviors;

@end

@implementation BehaviorWithCode

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dog&human"]];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 250);
    [self.view addSubview:imageView];
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 250)];
    tableHeader.backgroundColor = [UIColor clearColor];
    
    //视差效果
    NKParallaxHeaderBehavior *parallaxBehavior = [[NKParallaxHeaderBehavior alloc] init];
    parallaxBehavior.targetView = imageView;
    self.parallaxBehavior = parallaxBehavior;
    
    //导航栏渐变效果
    NKNavBarGradientBehavior *navBarBehavior = [[NKNavBarGradientBehavior alloc] init];
    navBarBehavior.owner = self;
    self.navBarBehavior = navBarBehavior;
    
    //代理转发的目标，会将事件转发到所有能处理事件的代理对象，因为多重代理对象内部不会强引用数组中的对象，所以数组中的self不会循环引用，同时，其他behavior需要再此控制器中强引用，防止被释放
    NSArray *delegates = @[self, parallaxBehavior, navBarBehavior];
    NKMultipleProxyBehavior *behaviors = [[NKMultipleProxyBehavior alloc]init];
    behaviors.delegateTargets = delegates;
    self.behaviors = behaviors;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = (id<UITableViewDataSource>)self.behaviors;
    tableView.delegate = (id<UITableViewDelegate>)self.behaviors;
    tableView.tableHeaderView = tableHeader;
    tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navBarBehavior onViewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navBarBehavior onViewWillDisAppear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}


@end
