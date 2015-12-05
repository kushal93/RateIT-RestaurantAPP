//
//  Tab.m
//  testJson
//
//  Created by teambak 2015 on 11/3/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import "Tab.h"

@interface Tab ()

@end

@implementation Tab




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setSelectedImageTintColor:[UIColor redColor]];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor yellowColor],NSFontAttributeName:[UIFont fontWithName:@"Roboto-Medium" size:11.0]} forState:UIControlStateNormal];
    
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
