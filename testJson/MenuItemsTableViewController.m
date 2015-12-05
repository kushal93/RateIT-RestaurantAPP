

#import "MenuItemsTableViewController.h"
#import "ViewController.h"


//#define JSON_FILE_URL @"http://10.0.0.8:7002/search?data=restaurant:Gaucho Parrilla Argentina"

@interface MenuItemsTableViewController ()
@property (strong, nonatomic) NSArray *names;
@property (strong, nonatomic) NSArray *description;
@property (strong, nonatomic) NSArray *data;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end

@implementation MenuItemsTableViewController
@synthesize names;
@synthesize description;
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
    self.title = @"Menu Items";
     //   NSData *utf8Data = [playURL2 dataUsingEncoding:NSUTF8StringEncoding];
    
    // Download JSON
    NSData *JSONData = [NSData dataWithContentsOfURL:[NSURL URLWithString:playURL2]];
    // Parse JSON
    NSArray *jsonResult = [NSJSONSerialization JSONObjectWithData:JSONData options:kNilOptions error:nil];
    self.data = jsonResult;
    NSMutableArray *_names = [NSMutableArray array];
    NSMutableArray *_description = [NSMutableArray array];
    for (id item in jsonResult)
    {
        [_names addObject:[NSString stringWithFormat:@"%@", item[@"name"]]];
        [_description addObject:[NSString stringWithFormat:@"%@", item[@"description"]]];
    }
    
    self.names = _names;
    self.description=_description;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
   //     [[cell detailTextLabel] setNumberOfLines:0];
   //     [[cell detailTextLabel] setLineBreakMode:UILineBreakModeWordWrap];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
        
    } else {
        cell.textLabel.text = self.names[indexPath.row];
        cell.detailTextLabel.text = self.description[indexPath.row];
        
      //  cell.imageView.image = [UIImage imageNamed:@"menuitem.png"];
//        cell.detailTextLabel.text = @"hi";
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *stringVariable = cell.textLabel.text;
    NSString *stringvariable1 = cell.detailTextLabel.text;
    menuitemName = stringVariable;
    menuitemDescription = stringvariable1;
    
    NSString* string2 = [stringVariable stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    
    NSString *urldata = @"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/getRating?data=";
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,string2];
    finMenuItem = sendCuisineItem1;
  //  NSLog(@"Value of table cell = %@", stringVariable);
    
    [self performSegueWithIdentifier:@"ShowDetail" sender:tableView];
    
    
    
}

@end
