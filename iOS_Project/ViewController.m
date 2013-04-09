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
    CLLocation *loc;
}

@end

@implementation ViewController

@synthesize places;
@synthesize tableviewController;
@synthesize searchResults;
@synthesize detailView;
@synthesize originalTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataConnect = [[DataConnect alloc] init];
    locations = [[Places alloc] init];
    locationTmp =[[Places alloc] init];
    detailView = [[DetailViewController alloc] init];
    [dataConnect openDatabase];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated{
    //places = [dataConnect getPlaces:@"places"];
    locationTmp = [[dataConnect getPlaces:@"places"] objectAtIndex:0];
    loc = [[CLLocation alloc] initWithLatitude:[locationTmp.lat doubleValue] longitude:[locationTmp.log doubleValue]];
    places = [self placesInRange:300000 fromGpsLocation:loc];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        locations = [searchResults objectAtIndex:indexPath.section];
        cell = (TableDataCell *)[self.originalTableView dequeueReusableCellWithIdentifier:identifier];
    }else{
        locations = [places objectAtIndex:indexPath.section];
    }
    cell.locationType.text = locations.type;
    cell.locationAddress.text = locations.adr;
    [cell.locationImage setImageWithURL:[NSURL URLWithString:locations.thumb_img] placeholderImage: [UIImage imageNamed:@"placeholder"]];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        locations = [searchResults objectAtIndex:section];
    }else{
        locations = [places objectAtIndex:section];
    }
    return locations.name;
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
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
    [self setOriginalTableView:nil];
    [super viewDidUnload];
}

- (NSMutableArray *) placesInRange:(double)range fromGpsLocation:(CLLocation *)location{
    NSMutableArray *result;
    NSMutableArray *data;
    NSMutableDictionary *tmp;
    NSMutableArray *dis;
    Places *place;
    CLLocation *loc2;
    result = [[NSMutableArray alloc] init];
    data = [dataConnect getPlaces:@"places"];
    tmp = [[NSMutableDictionary alloc] init];
    dis = [[NSMutableArray alloc] init];
    for (int x=0; x<[data count]; x++) {
        place = [[Places alloc]init];
        place = [data objectAtIndex:x];
        loc2 = [[CLLocation alloc] initWithLatitude:[place.lat doubleValue] longitude:[place.log doubleValue]];
        CLLocationDistance distance = [loc2 distanceFromLocation:location];
        if (distance <= range) {
            NSNumber *num = [NSNumber numberWithDouble:distance];
            [tmp setObject:place forKey:num];
            [dis addObject:num];
        }
    }
    [dis sortUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = a;
        NSNumber *second = b;
        return [first compare:second];
    }];
    for (int x=0; x<[dis count]; x++){
        [result addObject:[tmp objectForKey:[dis objectAtIndex:x]]];
    }
    return result;
}

- (void) filterContentForSearchText: (NSString *) searchText scope: (NSString*) scope{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name contains[cd] %@) OR (adr contains[cd] %@) OR (type contains[cd] %@)", searchText, searchText, searchText];
    searchResults = (NSMutableArray *)[places filteredArrayUsingPredicate:predicate];
}

- (BOOL) searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    tableView.rowHeight = 120;
}
@end
