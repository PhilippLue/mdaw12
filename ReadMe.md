#OpenCV

Codebeispiele zur [OpenCV Library](www.opencv.org). Für die Ausführung der Beispiele ist es notwendig die [iOS Version](http://opencv.org/downloads.html) zum Projekt hinzuzufügen.

##Allgemeines

In diesen Beispielen wird die Frontkamera verwendet.

>self._videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;

Um die Rückkamera zu verwenden ändern Sie die **defaultAVCaptureDevicePosition** in **viewDidLoad** auf **AVCaptureDevicePositionBack**

>self._videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;

Um die Auflösung der Bilder bei der Aufnahme zu verändern wählen Sie die entsprechende Auflösung als **defaultAVCaptureSessionPreset**

>self._videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;

oder 

>self._videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset1280x720;

Bitte beachten Sie, dass die Auflösung einen Einfluss auf die Performance hat.

Wenn nicht anders genannt finden alle Änderungen in **processImage** statt

##Sample 1: Graustufen

>Mat image\_copy;

>cvtColor(image, image\_copy, COLOR\_BGR2GRAY);

**cvtColor** konvertiert den Farbraum eines Bildes. In diesem Fall von **BGR** nach **GRAY**
Vergessen Sie nicht das Bild am Schluss wieder nach **BGR** zu konvertieren um es anzuzeigen.

##Sample 2: Graustufen invertiert

>bitwise\_not(image\_copy, image\_copy);

**bitwise_not** invertiert alle Werte innerhalb der Bildmatrix

##Sample 3: Threshold

Es gibt in OpenCV 5 Arten des Thresholds.

0. Binary
1. Binary Inverted
2. Threshold Truncated
3. Threshold to Zero
4. Threshold to Zero Inverted

>threshold( image\_copy, image\_copy, 128, 255, 0 );

**threshold** führt einen Threshold auf das Bild aus. _128_ ist der Grenzwert, _255_ der Maximalwert und _0_ die Art des Thresholds

##Sample 4: Canny Edges

>Canny(image\_copy, image\_copy, 100, 200);

##Sample 5: Cascading Classifier

Deklaration des Classifiers im Header
>CascadeClassifier faceDetector;

Laden des Classifiers aus einer Datei in **viewDidLoad**
>NSString* cascadePath = [[NSBundle mainBundle]pathForResource:@"haarcascade\_frontalface\_alt" ofType:@"xml"];
>
>faceDetector.load([cascadePath UTF8String]);

>

>blur(image\_copy, image\_copy, cv::Size(3, 3) );
    
>std::vector<cv::Rect> faces;
>faceDetector.detectMultiScale(image\_copy, faces, 1.1, 3, 0|CV_HAAR_SCALE_IMAGE, cv::Size(30, 30));
    
>for (int i = 0; i < faces.size(); i++)
>{

>const cv::Rect& face = faces[i];

>cv::Point top\_left(face.x, face.y);

>cv::Point bottom\_right = top_left + cv::Point(face.width, face.height);
>      
>Scalar magenta = Scalar(255, 0, 255);
>cv::rectangle(image, top\_left, bottom\_right, magenta);

>}

