//
//  FinalRatingsViewController.m
//  testJson
//
//  Created by teambak 2015 on 10/26/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import "FinalRatingsViewController.h"

@interface FinalRatingsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *menuname;
@end



@implementation FinalRatingsViewController
@synthesize textField = textField;
@synthesize names;
@synthesize description;
@synthesize stars;
NSArray *_starButtons1;
int rating1;
NSString *playStars;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        mainArray = [[NSMutableArray alloc] initWithObjects:@"this", @"is", @"a", @"table", @"view", nil];
    
    playStars = @"3";
    _starButtons1 = @[starOne, starTwo, starThree, starFour, starFive];
    
    self.menu_desc.lineBreakMode = NSLineBreakByWordWrapping;
    self.menu_desc.numberOfLines = 5;
    self.menu_name.text = menuitemName;
    self.menu_desc.text = menuitemDescription;
    
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:finMenuItem]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    NSMutableArray *_description = [NSMutableArray array];
    NSMutableArray *_stars = [NSMutableArray array];
    for (id item in jsonResult)
    {
        [_names addObject:[NSString stringWithFormat:@"%@", item[@"usr"]]];
        [_description addObject:[NSString stringWithFormat:@"%@", item[@"review"]]];
        [_stars addObject:[NSString stringWithFormat:@"%@", item[@"rating"]]];
    }
    
    self.names = _names;
    self.description=_description;
    self.stars = _stars;
    
   // [tableView reloadData];
    
    for (int loop = 0; loop < 5; loop++) {
        [((UIButton*)_starButtons1[loop]) setBackgroundImage:[UIImage imageNamed:@"not_selected_star.png"] forState:UIControlStateNormal];
    }
    playStars = @"3";
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
}


-(IBAction)btn_get_clicked:(id)sender{
   // [tableView reloadData];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    NSString *someText = textField.text;
 //   [data release];
    
    NSString* string1 = [userName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
     NSString* string2 = [menuitemName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
     NSString* string3 = [someText stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
//    NSLog(@"Value of table cell = %@", stringVariable);
//    restPlay = stringVariable;
    
    
    
    
    NSString *urldata =@"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/giveRating?data=";
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,string1];
    
    NSString *sendCuisineItem2 = [NSString stringWithFormat: @"%@:%@", sendCuisineItem1,string2];
    
    NSString *sendCuisineItem3 = [NSString stringWithFormat: @"%@:%@", sendCuisineItem2,string3];
    
    NSString *sendCuisineItem4 = [NSString stringWithFormat: @"%@:%@", sendCuisineItem3,playStars];
    
    playURL1=sendCuisineItem1;
    
    NSLog(@"Value of playURL1 = %@", sendCuisineItem4);
    

    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:sendCuisineItem4];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
//    [connection release];
    
    //start the connection
    [connection start];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!!"
                                                    message:@"Your Review has been posted!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:finMenuItem]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    NSMutableArray *_description = [NSMutableArray array];
    NSMutableArray *_stars = [NSMutableArray array];
    for (id item in jsonResult)
    {
        [_names addObject:[NSString stringWithFormat:@"%@", item[@"usr"]]];
        [_description addObject:[NSString stringWithFormat:@"%@", item[@"review"]]];
        [_stars addObject:[NSString stringWithFormat:@"%@", item[@"rating"]]];
        
    }
    
    self.names = _names;
    self.description=_description;
    self.stars=_stars;

    
    [tableView reloadData];
    
  //  [alert release];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [textField endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 5;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
        return [self.names count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1 * 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
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
    
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
//        
//    } else {
//        cell.textLabel.text = self.names[indexPath.row];
//        cell.detailTextLabel.text = self.description[indexPath.row];
        //  cell.imageView.image = [UIImage imageNamed:@"menuitem.png"];
        //        cell.detailTextLabel.text = @"hi";
    
    //cell.accessoryView = imageView;
    
    //  cell.imageView.image = [UIImage imageNamed:@"menuitem.png"];
    //        cell.detailTextLabel.text = @"hi";
    
    cell.textLabel.text = self.names[indexPath.row];
    cell.detailTextLabel.text = self.description[indexPath.row];
    
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

   // }
    
    //  cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
//    
//  //  Player *player = (self.players)[indexPath.row];
//    
//    UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
//    nameLabel.text = self.names[indexPath.row];
//    
//    UILabel *gameLabel = (UILabel *)[cell viewWithTag:101];
//    gameLabel.text = self.description[indexPath.row];
//    
////    UIImageView *ratingImageView = (UIImageView *)[cell viewWithTag:102];
////    ratingImageView.image = [self imageForRating:player.rating];
//    
//    return cell;
//}

-(IBAction)press_1 {
    [self set_stars:1 :@"Horrific"];
    playStars = @"1";
}

-(IBAction)press_2 {
    [self set_stars:2 :@"nah!"];
    playStars = @"2";
}

-(IBAction)press_3 {
    [self set_stars:3 :@"Its ok"];
    playStars = @"3";
}

-(IBAction)press_4 {
    [self set_stars:4 :@"good"];
    playStars = @"4";
}

-(IBAction)press_5 {
    [self set_stars:5 :@"Amazing"];
    playStars = @"5";
}

-(void)set_stars:(int)num :(NSString *)desc {
    
    //    rating_name.text = [NSString stringWithFormat:@"%@", desc];
    
    for (int loop = 0; loop < 5; loop++) {
        
        if ((loop + 1) <= num) {
            [((UIButton*)_starButtons1[loop]) setBackgroundImage:[UIImage imageNamed:@"selected_star.png"] forState:UIControlStateNormal];
        }
        
        else {
            [((UIButton*)_starButtons1[loop]) setBackgroundImage:[UIImage imageNamed:@"not_selected_star.png"] forState:UIControlStateNormal];
        }
    }
    
    rating1 = num;
}

@end
