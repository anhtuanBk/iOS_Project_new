//
//  DetailViewController.m
//  iOS_Project
//
//  Created by Quyen Xuan on 1/15/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize locationImageDetail;
@synthesize decription;
@synthesize location_detail;
@synthesize link;
@synthesize imageLoading;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    link = [NSURL URLWithString:location_detail.link];
    decription.text = location_detail.full_desc;
    if([location_detail.full_desc isEqualToString:@""]){
        decription.text = @"Xin lỗi! Hiện tại chúng tôi chưa có thông tin chi tiết về địa điểm này. Bạn vui lòng quay lại sau hoặc đóng góp thông tin cho địa điểm bằng cách gửi email tới: abc@gmail.com. Chúng tôi sẽ cập nhật thông tin nhanh nhất có thể.";
    }
    self.navigationItem.title = location_detail.name;
    [imageLoading startAnimating];
    [locationImageDetail setImageWithURL:[NSURL URLWithString:location_detail.full_img] placeholderImage: [UIImage imageNamed:@"placeholder"]];
    [imageLoading stopAnimating];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)socialShareEvent:(id)sender {
    NSArray *activitiesItem = @[location_detail.short_desc, link];
    UIActivityViewController *activities = [[UIActivityViewController alloc] initWithActivityItems:activitiesItem applicationActivities:nil];
    [self presentViewController:activities animated:YES completion:nil];
}

- (id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType{
    return @"";
}

- (id) activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController{
    return @"Activities placeholder";
}

- (void)viewDidUnload {
    [self setImageLoading:nil];
    [super viewDidUnload];
}
@end
