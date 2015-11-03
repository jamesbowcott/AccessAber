#import <MapKit/MapKit.h>

@interface MainMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *indoorControlsView;
@property (weak, nonatomic) IBOutlet UIStepper *indoorLevelStepper;
@property (weak, nonatomic) IBOutlet UILabel *indoorLevelLabel;

@end
