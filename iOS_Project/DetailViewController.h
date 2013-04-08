//
//  DetailViewController.h
//  iOS_Project
//
//  Created by Quyen Xuan on 1/15/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Places.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>

@interface DetailViewController : UIViewController<UIActivityItemSource>{
    Places *location_detail;
}
@property (weak, nonatomic) IBOutlet UIImageView *locationImageDetail;
@property (weak, nonatomic) IBOutlet UITextView *decription;
@property (strong, nonatomic) Places *location_detail;
@property (strong, nonatomic) NSURL *link;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *imageLoading;
- (IBAction)socialShareEvent:(id)sender;
@end
