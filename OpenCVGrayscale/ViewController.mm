//
//  ViewController.m
//  OpenCVGrayscale
//
//  Created by Philipp Lütge on 30.11.16.
//  Copyright © 2016 Philipp Lütge. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self._videoCamera = [[CvVideoCamera alloc] initWithParentView:_imageView];
    self._videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self._videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self._videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self._videoCamera.defaultFPS = 30;
    
    self._videoCamera.delegate = self;
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus
- (void)processImage:(Mat&)image;
{
    Mat image_copy;
    cvtColor(image, image_copy, COLOR_BGR2GRAY);
    
    bitwise_not(image_copy, image_copy);
    
    /* 0: Binary
     1: Binary Inverted
     2: Threshold Truncated
     3: Threshold to Zero
     4: Threshold to Zero Inverted
     */
    // treshold image
    //threshold( image_copy, image_copy, 128, 255, 0 );
    
    //Canny(image_copy, image_copy, 100, 200);
    
    cvtColor(image_copy, image, COLOR_GRAY2BGRA);
}
#endif

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionStart:(id)sender {
    [self._videoCamera start];
}
@end
