//
//  SearchViewController.m
//  SearchTableViewDemo
//
//  Created by Arthur Knopper on 14-07-13.
//  Copyright (c) 2013 Arthur Knopper. All rights reserved.
//

#import "CuisineTypeTableViewController.h"
#import "ViewController.h"

@interface CuisineTypeTableViewController () <UISearchDisplayDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray *searchResults;


@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation CuisineTypeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableData = [@[@"American",@"Argentine",@"Asian Fusion",@"Delis",@"Italian",@"Thai"] mutableCopy];
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[self.tableData count]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    } else {
        return [self.tableData count];
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
        cell.textLabel.text = self.tableData[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"Cuisine.png"];
    }
    
    return cell;
}

#pragma mark UISearchDisplay delegate

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    [self.searchResults removeAllObjects];
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    self.searchResults = [NSMutableArray arrayWithArray:[self.tableData filteredArrayUsingPredicate:resultPredicate]];//[self.tableData filteredArrayUsingPredicate:resultPredicate];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *stringVariable = cell.textLabel.text;
    
    NSString* string2 = [stringVariable stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSLog(@"string2 = %@", string2);
    
    NSString *urldata =@"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/search?data=cuisine:";
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,string2];
    
    playURL = sendCuisineItem1;
    NSLog(@"Button pressed1: %@", playURL);
}

@end