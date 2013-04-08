//
//  ViewController.m
//  iOS_Project
//
//  Created by Quyen Xuan on 1/13/13.
//  Copyright (c) 2013 Quyen Xuan. All rights reserved.
//

#import "ViewController.h"
@interface ViewController (){
    DataConnect *dataConnect;
    Places *locations;
    Places *locationTmp;
    BOOL isSearch;
}

@end

@implementation ViewController

@synthesize imageURLs;
@synthesize places;
@synthesize tableviewController;
@synthesize searchBar;
@synthesize searchResults;
@synthesize detailView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isSearch = NO;
    dataConnect = [[DataConnect alloc] init];
    locations = [[Places alloc] init];
    locationTmp =[[Places alloc] init];
    detailView = [[DetailViewController alloc] init];
    [dataConnect openDatabase];
   // places = [dataConnect getPlaces:@"places"];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    self.searchBar.showsScopeBar = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated{
    if (isSearch) {
        places = searchResults;
    }else{
        places = [dataConnect getPlaces:@"places"];
    }
    [tableviewController reloadData];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (isSearch) {
        return [searchResults count];
    }
    return [places count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"tableData";
    TableDataCell *cell = (TableDataCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = (TableDataCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (isSearch) {
        locations = [searchResults objectAtIndex:indexPath.section];
    }else{
        locations = [places objectAtIndex:indexPath.section];
    }
    cell.locationType.text = locations.type;
    cell.locationAddress.text = locations.adr;
    [cell.locationImage setImageWithURL:[NSURL URLWithString:locations.thumb_img] placeholderImage: [UIImage imageNamed:@"placeholder.png"]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (isSearch) {
        locations = [searchResults objectAtIndex:section];
    }else{
        locations = [places objectAtIndex:section];
    }
    return locations.name;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isSearch) {
        locationTmp = [searchResults objectAtIndex:indexPath.section];
    }else{
        locationTmp = [places objectAtIndex:indexPath.section];
    }
    return indexPath;
}

- (IBAction)showMaps:(id)sender {
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"locationsegue"]) {
        detailView = (DetailViewController *)[segue destinationViewController];
        self.detailView.location_detail = locationTmp;
    }
}
- (void)viewDidUnload {
    [self setSearchBar:nil];
    [super viewDidUnload];
}
    
@end
