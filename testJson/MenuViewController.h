
#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    IBOutlet UITextField *category;
    NSMutableArray *pastCategory;
    NSMutableArray *autocompleteData;
    UITableView *autocompleteTableView;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, retain) IBOutlet UITextField *category;
@property (nonatomic, retain) NSMutableArray *pastCategory;
@property (nonatomic, retain) NSMutableArray *autocompleteData;
@property (nonatomic, retain) IBOutlet UITableView *autocompleteTableView;
@property (nonatomic,retain) IBOutlet UITextField *nCategory;

-(void)displayErrorMsg:(NSString *)errMsg;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

- (IBAction)checkContinue:(id)sender;

- (IBAction)addNewCategory:(id)sender;

@end
