//
//  ViewController.m
//  NKBehaviorDemo
//
//  Created by Nick Wang on 2018/6/21.
//  Copyright © 2018年 feeyue. All rights reserved.
//

#import "ViewController.h"
#import "NKNavBarGradientBehavior.h"

@interface ViewController ()<UITableViewDataSource,UITabBarDelegate>
@property (nonatomic, strong) IBOutlet NKNavBarGradientBehavior *navBarBehavior;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame            = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    layer.colors           = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor ,(id)[UIColor clearColor].CGColor];
    layer.startPoint       = CGPointMake(0.5, 0.0);
    layer.endPoint         = CGPointMake(0.5, 1.0);
    
    [self.view.layer insertSublayer:layer atIndex:1];
}
- (void)viewWillAppear:(BOOL)animated{
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

@end
