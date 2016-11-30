//
//  ViewController.h
//  OpenCVGrayscale
//
//  Created by Philipp Lütge on 30.11.16.
//  Copyright © 2016 Philipp Lütge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>

using namespace cv;

@interface ViewController : UIViewController<CvVideoCameraDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) CvVideoCamera* _videoCamera;

- (IBAction)actionStart:(id)sender;

@end

