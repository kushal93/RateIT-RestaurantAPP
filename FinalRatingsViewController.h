//
//  FinalRatingsViewController.h
//  testJson
//
//  Created by teambak 2015 on 10/26/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface FinalRatingsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{

    IBOutlet UITableView *tableView;
    NSMutableArray *mainArray;
    
    IBOutlet UIButton *starOne;
    IBOutlet UIButton *starTwo;
    IBOutlet UIButton *starThree;
    IBOutlet UIButton *starFour;
    IBOutlet UIButton *starFive;

}
@property (strong, nonatomic) IBOutlet UILabel *menu_name;
@property (strong, nonatomic) IBOutlet UILabel *menu_desc;
@property (strong, nonatomic) IBOutlet UITextView *textField;

@property (nonatomic, retain) NSMutableArray *pastCategory;
@property (nonatomic, retain) NSMutableArray *autocompleteData;

@property (retain, nonatomic) NSURLConnection *connection;
@property (retain, nonatomic) IBOutlet UIButton *btn_syncronous;
@property (retain, nonatomic) IBOutlet UIButton *btn_post;
@property (retain, nonatomic) IBOutlet UIButton *btn_get;
@property (retain, nonatomic) NSMutableData *receivedData;

@property (strong, nonatomic) NSArray *names;
@property (strong, nonatomic) NSArray *description;
@property (strong, nonatomic) NSArray *stars;

@property (strong, nonatomic) NSArray *data;

/*BUTTON EVENTS*/
-(IBAction)btn_get_clicked:(id)sender;
-(IBAction)btn_post_clicked:(id)sender;
-(IBAction)btn_syncronous_clicked:(id)sender;


-(IBAction)press_1;
-(IBAction)press_2;
-(IBAction)press_3;
-(IBAction)press_4;
-(IBAction)press_5;

-(void)set_stars:(int)num :(NSString *)desc;


@end
