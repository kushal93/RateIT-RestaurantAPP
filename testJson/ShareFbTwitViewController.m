//
//  ShareFbTwitViewController.m
//  testJson
//
//  Created by teambak 2015 on 10/6/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import "ShareFbTwitViewController.h"
#import <social/social.h>

@interface ShareFbTwitViewController ()

@end

@implementation ShareFbTwitViewController
@synthesize category = category;
//@synthesize pastCategory;
@synthesize textField = textField;
@synthesize autocompleteData;
@synthesize autocompleteTableView;
@synthesize names;
@synthesize data;
NSArray *_starButtons;
NSString *starplay;
int rating;

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    
//    self.pastCategory = [[NSMutableArray alloc] initWithObjects:@"Gaucho Parrilla Argentina",@"Szmidts Old World Deli",@"Butcher and the Rye",@"Smiling Banana Leaf",@"Spice Island Tea House",@"The Porch at Schenley",@"Piccolo Forno",@"Altius",@"Alla Famiglia",@"Dinette", nil];
    self.autocompleteData = [[NSMutableArray alloc] init];
    self.restname.text = restName;
    
    _starButtons = @[starOne, starTwo, starThree, starFour, starFive];
    
    
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:rateItem]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    for (id item in jsonResult)
        [_names addObject:[NSString stringWithFormat:@"%@", item[@"iname"]]];
    //self.tableData = [@[@"One",@"Two",@"Three",@"Twenty-one"] mutableCopy];
    self.names = _names;
    
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [self.view addSubview:autocompleteTableView];
    
    category.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    
    for (int loop = 0; loop < 5; loop++) {
        [((UIButton*)_starButtons[loop]) setBackgroundImage:[UIImage imageNamed:@"not_selected_star.png"] forState:UIControlStateNormal];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [textField endEditing:YES];
}




- (IBAction)postToTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:textField.text];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)postToFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:textField.text];
        [self presentViewController:controller animated:YES completion:Nil];
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

- (IBAction)addNewCategory:(id)sender {
    
    if ([_nCategory.text isEqualToString:@""])
    {
        
        [self displayErrorMsg:@"New Category Name cannot be empty"];
        [_nCategory becomeFirstResponder];
        
    }
    else
    {
        // Clean up UI
        [category resignFirstResponder];
        autocompleteTableView.hidden = YES;
        
        // Add the Category to the list of entered categories as long as it isn't already there
        if (![names containsObject:_nCategory.text]) {
            [names addObject:_nCategory.text];
        }
    }
    
}

-(void)dismissKeyboard {
    [category resignFirstResponder];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteData removeAllObjects];
    for(NSString *curString in names) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompleteData addObject:curString];
        }
    }
    [autocompleteTableView reloadData];
}

-(IBAction)btn_get_clicked:(id)sender{
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    NSString *some = textField.text;
    //   [data release];
    
    NSString* string1 = [userName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString* string2 = [category.text stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString* string3 = [some stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    //    NSLog(@"Value of table cell = %@", stringVariable);
    //    restPlay = stringVariable;
    
    
    NSString *urldata =@"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/giveRating?data=";
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,string1];
    
    NSString *sendCuisineItem2 = [NSString stringWithFormat: @"%@:%@", sendCuisineItem1,string2];
    
    NSString *sendCuisineItem3 = [NSString stringWithFormat: @"%@:%@", sendCuisineItem2,string3];
    
    NSString *sendCuisineItem4 = [NSString stringWithFormat: @"%@:%@", sendCuisineItem3,starplay];
    
    
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
                                                    message:@"Menu Item Rating Posted Successfully!!!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    

    
    
}

-(void)displayErrorMsg:(NSString *)errMsg{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error Message"
                          message:[NSString stringWithFormat:@"%@",errMsg]
                          delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteData.count;
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    if (!cell)
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    cell.textLabel.text = [autocompleteData objectAtIndex:indexPath.row];
//    return cell;
    
    //  cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    category.text = selectedCell.textLabel.text;
    //  [self.view endEditing:YES];
    autocompleteTableView.hidden = YES;
    
    //  [self goPressed];
    
}

-(IBAction)press_1 {
    [self set_stars:1 :@"Horrific"];
    starplay = @"1";
}

-(IBAction)press_2 {
    [self set_stars:2 :@"nah!"];
     starplay = @"2";
}

-(IBAction)press_3 {
    [self set_stars:3 :@"Its ok"];
     starplay = @"3";
}

-(IBAction)press_4 {
    [self set_stars:4 :@"good"];
     starplay = @"4";
}

-(IBAction)press_5 {
    [self set_stars:5 :@"Amazing"];
     starplay = @"5";
}

-(void)set_stars:(int)num :(NSString *)desc {
    
//    rating_name.text = [NSString stringWithFormat:@"%@", desc];
    
    for (int loop = 0; loop < 5; loop++) {
        
        if ((loop + 1) <= num) {
            [((UIButton*)_starButtons[loop]) setBackgroundImage:[UIImage imageNamed:@"selected_star.png"] forState:UIControlStateNormal];
        }
        
        else {
            [((UIButton*)_starButtons[loop]) setBackgroundImage:[UIImage imageNamed:@"not_selected_star.png"] forState:UIControlStateNormal];
        }
    }
    
    rating = num;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
