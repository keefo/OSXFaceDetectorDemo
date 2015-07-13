//
//  AppDelegate.m
//  FaceDetector
//
//  Created by Xu Lian on 2015-07-13.
//  Copyright (c) 2015 Beyondcow. All rights reserved.
//

#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    NSString *path = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"jpg"];
    CIImage * image = [CIImage imageWithContentsOfURL:[NSURL fileURLWithPath:path]];
    
    NSImage *nsimage = [[NSImage alloc] initWithContentsOfFile:path];
    
    CIDetector *faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                  context:nil
                                                  options:@{ CIDetectorAccuracy : CIDetectorAccuracyLow,
                                                             CIDetectorTracking : @NO
                                                             }];
    NSArray *features = [faceDetector featuresInImage:image];
    [nsimage lockFocus];
    for ( CIFaceFeature *feature in features ) {
        CGRect rect= feature.bounds;
        NSBezierPath *b = [NSBezierPath bezierPathWithRect:rect];
        [b setLineWidth:2];
        [[NSColor whiteColor] setStroke];
        [b stroke];
    }
    [nsimage unlockFocus];
    [_imageView setImage:nsimage];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
