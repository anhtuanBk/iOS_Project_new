//
//  ViewController.h
//  iOS_Project
//
//  Created by Quyen Xuan on 1/13/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import "Places.h"
#import "TableDataCell.h"
#import "DataConnect.h"
#import "DetailViewController.h"

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>{
}
@property (strong, nonatomic) IBOutlet UITableView *tableviewController;
@property (strong, nonatomic) NSArray *imageURLs;
@property (strong, nonatomic) NSMutableArray *places;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) DetailViewController *detailView;

- (IBAction)showMaps:(id)sender;

@end
