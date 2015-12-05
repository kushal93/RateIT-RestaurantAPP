//
//  DetailHistoryViewController.m
//  testJson
//
//  Created by teambak 2015 on 11/2/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import "DetailHistoryViewController.h"
#import "ViewController.h"




@interface DetailHistoryViewController ()

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSString *names;
@property (strong, nonatomic) NSArray *stars;


@end



@implementation DetailHistoryViewController
@synthesize names;
@synthesize data;
@synthesize stars;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.itemname1.text = itemname;
    self.itemreview1.text = itemreview;
    
    
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:finURL]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    //NSMutableArray *_description = [NSMutableArray array];
    NSMutableArray *_stars = [NSMutableArray array];
    NSString *rev;
    NSString *revtime;
    for (id item in jsonResult)
    {
        //[_names addObject:[NSString stringWithFormat:@"%@", item[@"review"]]];
        rev = [NSString stringWithFormat:@"%@", item[@"review"]];
        revtime = [NSString stringWithFormat:@"%@", item[@"rtime"]];
        //[_description addObject:[NSString stringWithFormat:@"%@", item[@"item"]]];
        [_stars addObject:[NSString stringWithFormat:@"%@", item[@"rating"]]];
        
    }
    
    self.names=_names;
    self.stars=_stars;
    
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"\"%@\"", rev];
    self.reviewlabel.text = sendCuisineItem1;
    self.reviewTime.text = revtime;
    
    self.reviewlabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.reviewlabel.layer.borderWidth = 0.3;
    
    self.restImage.image = [UIImage imageNamed:itemname];
    
    
    //NSDictionary *boy=self.stars;
    //NSString *str=[[NSString alloc]initWithFormat:@"%@",boy];
    NSString *str = [_stars objectAtIndex:0];
    NSInteger n=[str intValue];
    NSLog(@"the value:%@",str);
   // NSLog(@"the value:%@",kush);
    
    if(n ==0)
    {
    self.imgViewStars.image = [UIImage imageNamed:@"1star.png"];
    }
    if(n ==1)
    {
        self.imgViewStars.image = [UIImage imageNamed:@"1star.png"];
    }
    if(n ==2)
    {
        self.imgViewStars.image = [UIImage imageNamed:@"2star.png"];
    }
    if(n ==3)
    {
        self.imgViewStars.image = [UIImage imageNamed:@"3star.png"];
    }
    if(n ==4)
    {
        self.imgViewStars.image = [UIImage imageNamed:@"4star.png"];
    }
    if(n ==5)
    {
       self.imgViewStars.image = [UIImage imageNamed:@"5star.png"];
    }

    
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
