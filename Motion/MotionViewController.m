//
//  MotionViewController.m
//  Motion
//
//  Created by Alasdair Allan on 01/06/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "MotionViewController.h"

float rotX = 0.00f, oldX = 0.00f, rotY = 0.00f, rotZ = 0.00f;
float oldZ = 0.00f, oldY = 0.00f;
int flag = 0;
int loop = 0;





@implementation MotionViewController

@synthesize dataxyz;
@synthesize datax;
@synthesize datay;
@synthesize dataz;
@synthesize gabung;


- (void)accelerometer:(UIAccelerometer *)meter  didAccelerate:(UIAcceleration *)acceleration {
    rawAccelLabelX.text = [NSString stringWithFormat:@"%2.2f", acceleration.x];
    rawAccelIndicatorX.progress = ABS(acceleration.x);
    
    rawAccelLabelY.text = [NSString stringWithFormat:@"%2.2f", acceleration.y];
    rawAccelIndicatorY.progress = ABS(acceleration.y);
    
    rawAccelLabelZ.text = [NSString stringWithFormat:@"%2.2f", acceleration.z];
    rawAccelIndicatorZ.progress = ABS(acceleration.z);  
}

- (void) updateView:(NSTimer *)timer  {
    
    CMDeviceMotion *motionData = motionManager.deviceMotion;
    
    CMAttitude *attitude = motionData.attitude;
    CMAcceleration userAcceleration = motionData.userAcceleration;
    CMRotationRate rotate = motionData.rotationRate;
 
    
    yawLabel.text = [NSString stringWithFormat:@"%2.2f", attitude.yaw];
    pitchLabel.text = [NSString stringWithFormat:@"%2.2f", attitude.pitch];
    rollLabel.text = [NSString stringWithFormat:@"%2.2f", attitude.roll];
    
    accelIndicatorX.progress = ABS(userAcceleration.x);
    accelIndicatorY.progress = ABS(userAcceleration.y);
    accelIndicatorZ.progress = ABS(userAcceleration.z);
    accelLabelX.text = [NSString stringWithFormat:@"%2.2f",userAcceleration.x];
    accelLabelY.text = [NSString stringWithFormat:@"%2.2f",userAcceleration.y];
    accelLabelZ.text = [NSString stringWithFormat:@"%2.2f",userAcceleration.z];
    
    
    rotIndicatorX.progress = ABS(rotate.x);
    rotIndicatorY.progress = ABS(rotate.y);
    rotIndicatorZ.progress = ABS(rotate.z);
    
    rotasiX.text = [NSString stringWithFormat:@"%2.2f",rotate.x];
    rotasiY.text = [NSString stringWithFormat:@"%2.2f",rotate.y];
    rotasiZ.text = [NSString stringWithFormat:@"%2.2f",rotate.z];
    
    rotX += ABS(rotate.x-oldX)*100;
    rotZ += ABS(rotate.z-oldZ)*100;
    rotY += ABS(rotate.y-oldY)*100;
    
    loop +=1;
    
    if (loop == 3) {
        
        NSLog(@"%g,%g,%g",rotX,rotY,rotZ);
        if (flag == 1) {
            datax = [NSString stringWithFormat:@"%2.3f", rotX];
            datay = [NSString stringWithFormat:@"%2.3f", rotY];
            dataz = [NSString stringWithFormat:@"%2.3f", rotZ];
            dataxyz = [NSArray arrayWithObjects:datax,datay,dataz, nil];
            
            
            NSLog(@"%@",dataxyz);
            
            NSMutableString *printString = [NSMutableString stringWithString:@""];
            
            [printString appendString:[NSString stringWithFormat:@"%@,%@,%@\n",datax, datay, dataz] ];
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *path = [documentsDirectory stringByAppendingPathComponent:@"myfile.txt"];
            NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:path];
            [myHandle seekToEndOfFile];
            [myHandle writeData:[printString dataUsingEncoding:NSUTF8StringEncoding]];
            
        }
        
        rotX = 0;
        rotY = 0;
        rotZ = 0;
        oldX = 0;
        oldY = 0;
        oldZ = 0;
        loop = 0;
    }
    
    
    
    
    
    
}

- (void)dealloc {
    [yawLabel release];
    [pitchLabel release];
    [rollLabel release];
    [accelIndicatorX release];
    [accelIndicatorY release];
    [accelIndicatorZ release];
    [accelLabelX release];
    [accelLabelY release];
    [accelLabelZ release];
    [rotIndicatorX release];
    [rotIndicatorY release];
    [rotIndicatorZ release];
    [rotState release];
    [rawAccelIndicatorX release];
    [rawAccelIndicatorY release];
    [rawAccelIndicatorZ release];
    [rawAccelLabelX release];
    [rawAccelLabelY release];
    [rawAccelLabelZ release];
   
    [start release];
    [stop release];
    [resetData release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [stop setEnabled:NO];
    
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval =  1.0 / 30.0;
    [motionManager startDeviceMotionUpdates];
    if (motionManager.deviceMotionAvailable ) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(updateView:) userInfo:nil repeats:YES];
    } else {
        [motionManager stopDeviceMotionUpdates];
        [motionManager release];
    }
    
    accelerometer = [UIAccelerometer sharedAccelerometer];
    accelerometer.updateInterval = 0.1f;
    accelerometer.delegate = self;
    

    
}

- (void)viewDidUnload {
    [yawLabel release];
    yawLabel = nil;
    [pitchLabel release];
    pitchLabel = nil;
    [rollLabel release];
    rollLabel = nil;
    [accelIndicatorX release];
    accelIndicatorX = nil;
    [accelIndicatorY release];
    accelIndicatorY = nil;
    [accelIndicatorZ release];
    accelIndicatorZ = nil;
    [accelLabelX release];
    accelLabelX = nil;
    [accelLabelY release];
    accelLabelY = nil;
    [accelLabelZ release];
    accelLabelZ = nil;
    [rotIndicatorX release];
    rotIndicatorX = nil;
    [rotIndicatorY release];
    rotIndicatorY = nil;
    [rotIndicatorZ release];
    rotIndicatorZ = nil;

    
    [rotState release];
    rotState = nil;
    
    [timer invalidate];
    [motionManager stopDeviceMotionUpdates];
    [motionManager release];
        
    [rawAccelIndicatorX release];
    rawAccelIndicatorX = nil;
    [rawAccelIndicatorY release];
    rawAccelIndicatorY = nil;
    [rawAccelIndicatorZ release];
    rawAccelIndicatorZ = nil;
    [rawAccelLabelX release];
    rawAccelLabelX = nil;
    [rawAccelLabelY release];
    rawAccelLabelY = nil;
    [rawAccelLabelZ release];
    rawAccelLabelZ = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tombolStart:(id)sender {
    rotState.text = @"Ambil Data";
    if (flag == 0) {
        flag =1;
        [start setEnabled:NO];
        [resetData setEnabled:NO];
        [stop setEnabled:YES];
    }
    
}

- (IBAction)tombolStop:(id)sender {
    rotState.text = @"Idle";
    if (flag == 1) {
        flag = 0;
        
        [start setEnabled:YES];
        [resetData setEnabled:YES];
        [stop setEnabled:NO];
        
    }
    
}

- (IBAction)clearData:(id)sender {
    
    NSString *myString = [NSString stringWithFormat:@""];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSError *error;
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"myfile.txt"];
    BOOL success = [myString writeToFile:path atomically:YES];
    
    if (success) {
        UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"Sukses:" message:@"Data Berhasil Dihapus" delegate:self cancelButtonTitle:@"Tutup" otherButtonTitles:nil];
        [removeSuccessFulAlert show];
    }
    else
    {
        UIAlertView *removeSuccessFulAlert=[[UIAlertView alloc]initWithTitle:@"Gagal:" message:@"Data Gagal Berhasil Dihapus" delegate:self cancelButtonTitle:@"Tutup" otherButtonTitles:nil];
        [removeSuccessFulAlert show];
    }
    
    
}
@end
