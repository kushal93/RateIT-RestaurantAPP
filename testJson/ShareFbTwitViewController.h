//
//  ShareFbTwitViewController.h
//  testJson
//
//  Created by teambak 2015 on 10/6/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ViewController.h"

@interface ShareFbTwitViewController :UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    IBOutlet UITextField *category;
    NSMutableArray *pastCategory;
    NSMutableArray *autocompleteData;
    UITableView *autocompleteTableView;
    
    IBOutlet UIButton *starOne;
    IBOutlet UIButton *starTwo;
    IBOutlet UIButton *starThree;
    IBOutlet UIButton *starFour;
    IBOutlet UIButton *starFive;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (strong, nonatomic) IBOutlet UILabel *restname;
@property (nonatomic, retain) IBOutlet UITextField *category;
//@property (nonatomic, retain) NSMutableArray *pastCategory;

@property (nonatomic, retain) NSMutableArray *autocompleteData;
@property (nonatomic, retain) IBOutlet UITableView *autocompleteTableView;
@property (nonatomic,retain) IBOutlet UITextField *nCategory;

@property (strong, nonatomic) NSMutableArray *names;
@property (strong, nonatomic) NSArray *data;

@property (strong, nonatomic) IBOutlet UITextView *textField;
-(void)displayErrorMsg:(NSString *)errMsg;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

- (IBAction)checkContinue:(id)sender;

- (IBAction)addNewCategory:(id)sender;

- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) IBOutlet UIButton *btn_syncronous;
@property (retain, nonatomic) IBOutlet UIButton *btn_post;
@property (retain, nonatomic) IBOutlet UIButton *btn_get;
@property (retain, nonatomic) NSMutableData *receivedData;


-(IBAction)press_1;
-(IBAction)press_2;
-(IBAction)press_3;
-(IBAction)press_4;
-(IBAction)press_5;

-(void)set_stars:(int)num :(NSString *)desc;






@end
