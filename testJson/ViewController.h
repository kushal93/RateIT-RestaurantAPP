//
//  ViewController.h
//  testJson
//
//  Created by teambak 2015 on 10/4/15.
//  Copyright © 2015 kushal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>



@interface ViewController : UIViewController <FBLoginViewDelegate>


extern NSString *playURL;
extern NSString *playURL1;
extern NSString *playURL2;
extern NSString *playURL3;
extern NSString *restPlay;
extern NSString *menuitemName;
extern NSString *menuitemDescription;
extern NSString *userName;
extern NSString *restName;
extern NSString *finMenuItem;
extern NSString *rateItem;
extern NSString *itemname;
extern NSString *itemreview;
extern NSString *finURL;

@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;

@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;

@property (weak, nonatomic) IBOutlet UILabel *lblUsername;

@property (weak, nonatomic) IBOutlet UILabel *lblEmail;

@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;

@property (retain, nonatomic) NSURLConnection *connection;

@end

