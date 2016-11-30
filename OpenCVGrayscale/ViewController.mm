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
    
    NSString* cascadePath = [[NSBundle mainBundle]pathForResource:@"haarcascade_frontalface_alt" ofType:@"xml"];
    
    faceDetector.load([cascadePath UTF8String]);
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus
- (void)processImage:(Mat&)image;
{
    Mat image_copy;
    cvtColor(image, image_copy, COLOR_BGR2GRAY);
    
    //bitwise_not(image_copy, image_copy);
    
    /* 0: Binary
     1: Binary Inverted
     2: Threshold Truncated
     3: Threshold to Zero
     4: Threshold to Zero Inverted
     */
    //threshold( image_copy, image_copy, 128, 255, 0 );
    
    //Canny(image_copy, image_copy, 100, 200);
    
    //cvtColor(image_copy, image, COLOR_GRAY2BGRA);
    
    blur(image_copy, image_copy, cv::Size(3, 3) );
    
    std::vector<cv::Rect> faces;
    faceDetector.detectMultiScale(image_copy, faces, 1.1, 3, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
    for (int i = 0; i < faces.size(); i++)
    {
        const cv::Rect& face = faces[i];
        cv::Point top_left(face.x, face.y);
        cv::Point bottom_right = top_left + cv::Point(face.width, face.height);
        
        Scalar magenta = Scalar(255, 0, 255);
        cv::rectangle(image, top_left, bottom_right, magenta);
    }
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
