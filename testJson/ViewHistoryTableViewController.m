//
//  ViewHistoryTableViewController.m
//  testJson
//
//  Created by teambak 2015 on 10/31/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import "ViewHistoryTableViewController.h"
#import "ViewController.h"
#import "HJManagedImageV.h"


//#define JSON_FILE_URL @"http://10.0.0.8:7002/search?data=restaurant:Gaucho Parrilla Argentina"

@interface ViewHistoryTableViewController ()
@property (strong, nonatomic) NSArray *names;
@property (strong, nonatomic) NSArray *description;
@property (strong, nonatomic) NSArray *stars;
@property (strong, nonatomic) NSArray *data;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation ViewHistoryTableViewController
@synthesize names;
@synthesize description;
@synthesize data;
@synthesize stars;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *nameurl = @"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/history?data=";
    NSString* string3 = [userName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString *sendurl = [NSString stringWithFormat: @"%@%@", nameurl,string3];
    
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:sendurl]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    NSMutableArray *_description = [NSMutableArray array];
    NSMutableArray *_stars = [NSMutableArray array];
    for (id item in jsonResult)
    {
        [_names addObject:[NSString stringWithFormat:@"%@", item[@"rest"]]];
        [_description addObject:[NSString stringWithFormat:@"%@", item[@"item"]]];
        [_stars addObject:[NSString stringWithFormat:@"%@", item[@"rating"]]];
        
    }
    
    self.names = _names;
    self.description=_description;
    self.stars=_stars;
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.names count]];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //[super viewWillAppear:animated];
    self.title = @"History";
    //   NSData *utf8Data = [playURL2 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *nameurl = @"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/history?data=";
    NSString* string3 = [userName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString *sendurl = [NSString stringWithFormat: @"%@%@", nameurl,string3];
    
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:sendurl]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    NSMutableArray *_description = [NSMutableArray array];
    NSMutableArray *_stars = [NSMutableArray array];
    for (id item in jsonResult)
    {
        [_names addObject:[NSString stringWithFormat:@"%@", item[@"rest"]]];
        [_description addObject:[NSString stringWithFormat:@"%@", item[@"item"]]];
        [_stars addObject:[NSString stringWithFormat:@"%@", item[@"rating"]]];
        
    }
    
    self.names = _names;
    self.description=_description;
    self.stars=_stars;
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.names count]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    } else {
        return [self.names count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1star.png"]];
     UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1star.png"]];
     UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2star.png"]];
     UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3star.png"]];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4star.png"]];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5star.png"]];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        //     [[cell detailTextLabel] setNumberOfLines:0];
        //     [[cell detailTextLabel] setLineBreakMode:UILineBreakModeWordWrap];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        
    } else {
        cell.textLabel.text = self.names[indexPath.row];
        cell.detailTextLabel.text = self.description[indexPath.row];
        cell.accessoryView = imageView;
        
        //  cell.imageView.image = [UIImage imageNamed:@"menuitem.png"];
        //        cell.detailTextLabel.text = @"hi";
        
        NSDictionary *boy=[self.stars objectAtIndex:indexPath.row];
        NSString *str=[[NSString alloc]initWithFormat:@"%@",boy];
        NSInteger n=[str intValue];
        NSLog(@"the value:%@",str);
        
        if(n ==0)
        {
            cell.accessoryView = imageView;
        }
        if(n ==1)
        {
            cell.accessoryView = imageView1;
        }
        if(n ==2)
        {
            cell.accessoryView = imageView2;
        }
        if(n ==3)
        {
            cell.accessoryView = imageView3;
        }
        if(n ==4)
        {
            cell.accessoryView = imageView4;
        }
        if(n ==5)
        {
            cell.accessoryView = imageView5;
        }
    }
    
    
    //  cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    
//    static NSString *CellIdentifier = @"Cell";
//    HJManagedImageV* mi;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    //    if (cell == nil) {
//    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    mi = [[HJManagedImageV alloc] initWithFrame:CGRectMake(-18,-2,90,90)];
//    mi.tag = 999;
//    [cell addSubview:mi];
//    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    CGSize sizeTitle = [[self.names objectAtIndex:indexPath.row] sizeWithFont:[UIFont boldSystemFontOfSize:16.0]constrainedToSize:CGSizeMake(200, 40)lineBreakMode:UILineBreakModeWordWrap];
//    
//    float width = sizeTitle.width;
//    NSLog(@"Width %f", width);
//    width = width+15;
//    NSDictionary *boy=[self.stars objectAtIndex:indexPath.row];
//    NSString *str=[[NSString alloc]initWithFormat:@"%@",boy];
//    NSInteger n=[str intValue];
//    NSLog(@"the value:%@",str);
//    CGRect coreFrame;
//    if(width<170){
//        coreFrame = CGRectMake(2, 6, width, 40);
//    }
//    else{
//        coreFrame = CGRectMake(2, 6, 170, 40);
//        width = 175;
//    }
//    float k = width+85;
//    UILabel *lab = [[UILabel alloc] initWithFrame:coreFrame];
//    lab.text = [self.names objectAtIndex:indexPath.row];
//    [cell.contentView addSubview:lab];
//    
//    if(n ==0)
//    {
//        CGRect starFrame = CGRectMake(width,6, 85, 37);
//        
//        UIImageView *starImage = [[UIImageView alloc] initWithFrame:starFrame];
//        starImage.image = [UIImage imageNamed:@"nostar.png"];
//        starImage.backgroundColor=[UIColor clearColor];
//        [cell.contentView addSubview:starImage];
//        
//        NSString *boo=[[NSString alloc]initWithFormat:@"%d",n];
//        NSString *str=[[NSString alloc]initWithFormat:@"(%@)",boo];
//        // str=[str substringToIndex:4];
//        CGRect labelFrame = CGRectMake(k,6, 40, 40);
//        UILabel *Label = [[UILabel alloc] initWithFrame:labelFrame];
//        
//        Label.text=str;
//        Label.tag=1000;
//        Label.textColor=[UIColor grayColor];
//        [cell.contentView addSubview:Label];
//        
//        
//    }
//    if(n >=1)
//    {
//        CGRect starFrame = CGRectMake(width,6, 85, 37);
//        
//        UIImageView *starImage = [[UIImageView alloc] initWithFrame:starFrame];
//        starImage.image = [UIImage imageNamed:@"1star.png"];
//        [cell.contentView addSubview:starImage];
//        
//        NSString *boo=[[NSString alloc]initWithFormat:@"%d",n];
//        CGRect labelFrame = CGRectMake(k,6, 40, 40);
//        UILabel *Label = [[UILabel alloc] initWithFrame:labelFrame];
//        NSString *str=[[NSString alloc]initWithFormat:@"(%@)",boo];
//        Label.text=str;
//        Label.tag=1000;
//        Label.textColor=[UIColor grayColor];
//        [cell.contentView addSubview:Label];
//    }
//    if(n >=2)
//    {
//        CGRect starFrame = CGRectMake(width,6, 85, 37);
//        
//        UIImageView *starImage = [[UIImageView alloc] initWithFrame:starFrame];
//        starImage.image = [UIImage imageNamed:@"2star.png"];
//        [cell.contentView addSubview:starImage];
//        
//        NSString *boo=[[NSString alloc]initWithFormat:@"%d",n];
//        NSString *str=[[NSString alloc]initWithFormat:@"(%@)",boo];
//        CGRect labelFrame = CGRectMake(k,6, 40,40);
//        UILabel *Label = [[UILabel alloc] initWithFrame:labelFrame];
//        Label.text=str;
//        Label.tag=1000;
//        Label.textColor=[UIColor grayColor];
//        // Label.backgroundColor=[UIColor clearColor];
//        [cell.contentView addSubview:Label];
//    }
//    if(n >=3)
//    {
//        CGRect starFrame = CGRectMake(width,6, 85, 37);
//        
//        UIImageView *starImage = [[UIImageView alloc] initWithFrame:starFrame];
//        starImage.image = [UIImage imageNamed:@"3star.png"];
//        [cell.contentView addSubview:starImage];
//        
//        NSString *boo=[[NSString alloc]initWithFormat:@"%d",n];
//        NSString *str=[[NSString alloc]initWithFormat:@"(%@)",boo];
//        //  str=[str substringToIndex:4];
//        
//        CGRect labelFrame = CGRectMake(k,6, 40,40);
//        UILabel *Label = [[UILabel alloc] initWithFrame:labelFrame];
//        
//        Label.text=str;
//        Label.tag=1000;
//        Label.textColor=[UIColor grayColor];
//        [cell.contentView addSubview:Label];
//        
//    }
//    if(n >= 4)
//    {
//        CGRect starFrame = CGRectMake(width,6, 85, 37);
//        
//        UIImageView *starImage = [[UIImageView alloc] initWithFrame:starFrame];
//        starImage.image = [UIImage imageNamed:@"4star.png"];
//        [cell.contentView addSubview:starImage];
//        
//        NSString *boo=[[NSString alloc]initWithFormat:@"%d",n];
//        NSString *str=[[NSString alloc]initWithFormat:@"(%@)",boo];
//        //str=[str substringToIndex:4];
//        
//        CGRect labelFrame = CGRectMake(k,6,40,40);
//        UILabel *Label = [[UILabel alloc] initWithFrame:labelFrame];
//        
//        Label.text=str;
//        Label.tag=1000;
//        Label.textColor=[UIColor grayColor];
//        //Label.backgroundColor=[UIColor clearColor];
//        [cell.contentView addSubview:Label];
//    }
//    if(n >= 5)
//    {
//        CGRect starFrame = CGRectMake(width,6, 85, 37);
//        
//        UIImageView *starImage = [[UIImageView alloc] initWithFrame:starFrame];
//        starImage.image = [UIImage imageNamed:@"5star.png"];
//        [cell.contentView addSubview:starImage];
//        
//        NSString *boo=[[NSString alloc]initWithFormat:@"%d",n];
//        NSString *str=[[NSString alloc]initWithFormat:@"(%@)",boo];
//        // str=[str substringToIndex:4];
//        
//        CGRect labelFrame = CGRectMake(k,6, 40,40);
//        UILabel *Label = [[UILabel alloc] initWithFrame:labelFrame];
//        Label.font = [UIFont systemFontOfSize:18];
//        
//        Label.text=str;
//        Label.tag=1000;
//        Label.textColor=[UIColor grayColor];
//        // Label.backgroundColor=[UIColor clearColor];
//        [cell.contentView addSubview:Label];
//    }
//    return cell;
//}





- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    [self.searchResults removeAllObjects];
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    self.searchResults = [NSMutableArray arrayWithArray:[self.names filteredArrayUsingPredicate:resultPredicate]];//[self.tableData filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *stringVariable = cell.textLabel.text;
    NSString *stringvariable1 = cell.detailTextLabel.text;
    itemname = stringVariable;
    itemreview = stringvariable1;
    
    NSString *nameurl1 = @"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/history1?data=";
    NSString* string4 = [userName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString* string5 = [stringvariable1 stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSString *sendurl1 = [NSString stringWithFormat: @"%@%@", nameurl1,string4];
    NSString *sendurl2 = [NSString stringWithFormat: @"%@:%@", sendurl1,string5];
    finURL = sendurl2;
    
    
    
    
    
//http://52.91.234.84:7002/history1?data=Venkat_Kushal:beet
    
//    NSString* string2 = [stringVariable stringByReplacingOccurrencesOfString:@" " withString:@"_"];
//    
//    
//    NSString *urldata = @"http://10.0.0.8:7002/getRating?data=";
//    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,string2];
//    finMenuItem = sendCuisineItem1;
//    //  NSLog(@"Value of table cell = %@", stringVariable);
//    
    [self performSegueWithIdentifier:@"ShowDetailview" sender:tableView];
    
    
    
}

@end
