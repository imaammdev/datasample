//
//  MotionViewController.h
//  Motion
//
//  Created by Alasdair Allan on 01/06/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MotionViewController : UIViewController <UIAccelerometerDelegate> {
    
    IBOutlet UILabel *yawLabel;
    IBOutlet UILabel *pitchLabel;
    IBOutlet UILabel *rollLabel;
    
    IBOutlet UIProgressView *accelIndicatorX;
    IBOutlet UIProgressView *accelIndicatorY;
    IBOutlet UIProgressView *accelIndicatorZ;
    IBOutlet UILabel *accelLabelX;
    IBOutlet UILabel *accelLabelY;
    IBOutlet UILabel *accelLabelZ;
    

    
    IBOutlet UIProgressView *rotIndicatorX;
    IBOutlet UIProgressView *rotIndicatorY;
    IBOutlet UIProgressView *rotIndicatorZ;

    IBOutlet UILabel *rotState;
    
    CMMotionManager *motionManager;
    NSTimer *timer;
    
    IBOutlet UIProgressView *rawAccelIndicatorX;
    IBOutlet UIProgressView *rawAccelIndicatorY;
    IBOutlet UIProgressView *rawAccelIndicatorZ;
    IBOutlet UILabel *rawAccelLabelX;
    IBOutlet UILabel *rawAccelLabelY;
    IBOutlet UILabel *rawAccelLabelZ;
    
    
    IBOutlet UILabel *rotasiX;
    IBOutlet UILabel *rotasiY;
    IBOutlet UILabel *rotasiZ;


    IBOutlet UIButton *start;
    
    IBOutlet UIButton *stop;
    
    IBOutlet UIButton *resetData;
    
    UIAccelerometer *accelerometer;

}


@property (nonatomic, strong) NSArray *dataxyz;
@property (nonatomic, strong) NSString *datax;
@property (nonatomic, strong) NSString *datay;
@property (nonatomic, strong) NSString *dataz;
@property (nonatomic, strong) NSString *gabung;



- (IBAction)tombolStart:(id)sender;
- (IBAction)tombolStop:(id)sender;
- (IBAction)clearData:(id)sender;


@end
