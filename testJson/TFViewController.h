

#import <UIKit/UIKit.h>
#import "StarRatingControl.h"

@interface TFViewController : UIViewController <StarRatingDelegate>

@property (weak) IBOutlet UILabel *ratingLabel;
@property (weak) IBOutlet StarRatingControl *starRatingControl;

@end
