

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize category = category;
@synthesize pastCategory;
@synthesize autocompleteData;
@synthesize autocompleteTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /*
     * Now I am going to allocate memory and values to the tableData array 
     * which will be displayed in the UITableView.
     */
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]]];

    self.pastCategory = [[NSMutableArray alloc] initWithObjects:@"Gaucho Parrilla Argentina",@"Szmidts Old World Deli",@"Butcher and the Rye",@"Smiling Banana Leaf",@"Spice Island Tea House",@"The Porch at Schenley",@"Piccolo Forno",@"Altius",@"Alla Famiglia",@"Dinette", nil];
    self.autocompleteData = [[NSMutableArray alloc] init];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    
    /*
     * Below code is used to hide the table view once the menu screen loads.
     */
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [self.view addSubview:autocompleteTableView];
    
  //  tf = [[category alloc] init];
    
    
    category.autocapitalizationType = UITextAutocapitalizationTypeSentences;

    //UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(viewLogin)];
    
    //self.navigationItem.leftBarButtonItem = item;
}
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
        if (![pastCategory containsObject:_nCategory.text]) {
            [pastCategory addObject:_nCategory.text];
        }
    }
    
}

-(void)dismissKeyboard {
    [category resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [category endEditing:YES];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompleteData removeAllObjects];
    for(NSString *curString in pastCategory) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompleteData addObject:curString];
        }
    }
    [autocompleteTableView reloadData];
}

- (IBAction)checkContinue:(UIButton *)sender {
    if ([category.text isEqualToString:@""])
    {
        [self displayErrorMsg:@"Category Name cannot be empty"];
        [category becomeFirstResponder];
        
    }
   /* else{
        //This code will help to navigate from Login Screen to MenuViewController
        [self performSegueWithIdentifier:@"sw_contmenu" sender: self];
    }*/
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//
//    
//    CreateMenuController *destViewController = segue.destinationViewController;
//
//    if ([segue.identifier isEqualToString:@"sw_continue"]) {
//        destViewController.tempCat = category.text;
//            }
//    else if ([segue.identifier isEqualToString:@"sw_newmenu"]) {
//       destViewController.itemCat.text = _nCategory.text;
//        
//    }
//}

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return autocompleteData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [autocompleteData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    category.text = selectedCell.textLabel.text;
    
    restName = selectedCell.textLabel.text;
  //  [self.view endEditing:YES];
    autocompleteTableView.hidden = YES;
    
    NSString *string1 = selectedCell.textLabel.text;
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    NSLog(@"string2 = %@", string2);
    
    NSString *urldata =@"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/getItems?data=";
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,string2];
    rateItem = sendCuisineItem1;
    
    
    
  //  [self goPressed];
    
}

@end
