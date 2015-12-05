//
//  CuisineViewController.m
//  testJson
//
//  Created by teambak 2015 on 10/8/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import "CuisineViewController.h"
#import "ViewController.h"

@interface CuisineViewController ()

@end

@implementation CuisineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.pastCategory = [[NSMutableArray alloc] initWithObjects:@"JUICES & REFRESHERS",@"SMOOTHIES",@"HEALTH SHOTS",@"HOT BEVERAGES",@"BOWLS", nil];
//    self.autocompleteData = [[NSMutableArray alloc] init];
//    
//    autocompleteTableView.delegate = self;
//    autocompleteTableView.dataSource = self;
//    autocompleteTableView.scrollEnabled = YES;
//    autocompleteTableView.hidden = YES;
//    [self.view addSubview:autocompleteTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    autocompleteTableView.hidden = NO;
//    
//    NSString *substring = [NSString stringWithString:textField.text];
//    substring = [substring stringByReplacingCharactersInRange:range withString:string];
//    [self searchAutocompleteEntriesWithSubstring:substring];
//    return YES;
//}
//
//- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
//    
//    // Put anything that starts with this substring into the autocompleteUrls array
//    // The items in this array is what will show up in the table view
//    [autocompleteData removeAllObjects];
//    for(NSString *curString in pastCategory) {
//        NSRange substringRange = [curString rangeOfString:substring];
//        if (substringRange.location == 0) {
//            [autocompleteData addObject:curString];
//        }
//    }
//    [autocompleteTableView reloadData];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell = nil;
//    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
//    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]
//                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
//    }
//    
//    cell.textLabel.text = [autocompleteData objectAtIndex:indexPath.row];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//    category.text = selectedCell.textLabel.text;
//    
//    //  [self goPressed];
//    
//}

- (IBAction)buttonClicked:(id)sender {

    NSString *cuisineItem = [sender currentTitle];
    NSString *sendCuisine =@"cuisine:";
    NSString *sendCuisineItem = [NSString stringWithFormat: @"%@%@", sendCuisine,cuisineItem];
     NSLog(@"Button pressed: %@", sendCuisineItem);
    NSString *urldata =@"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/search?data=";
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,sendCuisineItem];
    
    playURL = sendCuisineItem1;
    NSLog(@"Button pressed1: %@", playURL);
    
    
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
