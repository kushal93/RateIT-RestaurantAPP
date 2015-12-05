//
//  ViewController.m
//  testJson
//
//  Created by teambak 2015 on 10/4/15.
//  Copyright © 2015 kushal. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

-(void)toggleHiddenState:(BOOL)shouldHide;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method implementation

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
}


#pragma mark - FBLoginView Delegate method implementation

-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    //   self.lblLoginStatus.text = @"You are logged in.";
    
    [self toggleHiddenState:NO];
}


-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"%@", user);
    self.profilePicture.profileID = user.id;
    self.lblUsername.text = user.name;
    self.lblEmail.text = [user objectForKey:@"email"];
    userName = user.name;
    
    
   // http://localhost:7002/signup?data=devudu:123
    NSString *abc = @"abc";
    
    NSString *urldata =@"http://RateIt-1276878390.us-east-1.elb.amazonaws.com/signup?data=";
    
    NSString* string2 = [userName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString *sendCuisineItem1 = [NSString stringWithFormat: @"%@%@", urldata,string2];
    //NSString* string2 = [stringVariable stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    NSString *sendCuisineItem2 = [NSString stringWithFormat: @"%@:%@", sendCuisineItem1,abc];

    
    NSURL *url = [NSURL URLWithString:sendCuisineItem2];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    //    [connection release];
    
    //start the connection
    [connection start];
    
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.lblLoginStatus.text = @"You are logged out";
    
    [self toggleHiddenState:YES];
}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
}


@end

