

#import "MenuTableViewController.h"
#import "ViewController.h"


//#define JSON_FILE_URL @"http://10.0.0.8:7002/search?data=restaurant:Gaucho Parrilla Argentina"

@interface MenuTableViewController () <UISearchDisplayDelegate>
@property (strong, nonatomic) NSArray *names;
@property (strong, nonatomic) NSArray *data;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation MenuTableViewController
@synthesize names;
@synthesize data;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Categories";
    
    // Download JSON
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:playURL1]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    for (id item in jsonResult)
        [_names addObject:[NSString stringWithFormat:@"%@", item[@"name"]]];
    
    self.names = _names;
    
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
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = self.names[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"Categories.png"];
    }
    
    //  cell.textLabel.text = self.names[indexPath.row];
    
    return cell;
}

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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *stringVariable = cell.textLabel.text;
    
    NSLog(@"Value of table cell = %@", stringVariable);
    
    NSString* string2 = [stringVariable stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSLog(@"string2 = %@", string2);
    
    NSString *escapedString = [string2 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSLog(@"Value of table cell = %@", stringVariable);

    NSString *urldata =@"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/search?data=category:";
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,escapedString];
    
    NSString *playmesafe=sendCuisineItem1;
    
    NSString *dude = restPlay;
    NSString *dude1 = [restPlay stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    
//      playURL2 = [NSString stringWithUTF8String:[[NSString stringWithFormat:@"%@",sendCuisineItem1] UTF8String]];
    
    NSString *sendCuisineItem2 = [NSString stringWithFormat: @"%@:%@", playmesafe,dude1];
    playURL2 = sendCuisineItem2;
    NSLog(@"Value of playURL2 = %@", playURL2);
    
//    NSMutableDictionary *sendAsJSON = [[NSMutableDictionary alloc]
//                                       initWithCapacity:1];
//    
//    [sendAsJSON setObject:stringVariable
//                   forKey:@"Data"];
//    
//    NSData *message = [NSJSONSerialization dataWithJSONObject: sendAsJSON
//                                                      options:0
//                                                        error:nil];
//    
//    /* Create NSURL to declare the HTTP path */
//    NSURL *apiURL = [NSURL URLWithString:@"http://10.0.0.8:7002/"];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: apiURL];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    [request setHTTPBody:message];
//    
//    NSURLResponse *serverResponse;
//    NSError *e;
//    
//    [NSURLConnection sendSynchronousRequest:request
//                          returningResponse:&serverResponse
//                                      error:&e];
    
    // load next view and set title:
    //    MyView *nextView = [[MyView alloc] initWithNibName:@"MyView" bundle:nil];
    //    nextView.title = stringVariable;
    //    [self.navigationController pushViewController:nextView animated:YES];
}

@end
