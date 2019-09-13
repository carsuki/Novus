//
//  NVSRepositoriesViewController.m
//  Novus
//
//  Created by EvenDev on 26/08/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSRepositoriesViewController.h"

@interface NVSRepositoriesViewController ()

@end

@implementation NVSRepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.lastDateFormatter = [[NSDateFormatter alloc] init];
    [self.lastDateFormatter setDateFormat:@"MMM d, h:mm a"];


    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    self.dateLabel.stringValue = [formatter stringFromDate:[NSDate date]];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[NVSPackageManager sharedInstance] sources].count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSRepoCellView *view = [tableView makeViewWithIdentifier:@"RepoCell" owner:self];
    NVSRepo *repo = [[[NVSPackageManager sharedInstance] sources] objectAtIndex:row];
    view.textField.stringValue = repo.label;
    view.descField.stringValue = repo.desc;
    view.infoField.stringValue = [NSString stringWithFormat:@"Packages: %ld \nLast update: %@", (long)repo.packages.count, [self.lastDateFormatter stringFromDate:repo.lastUpdated]];
    view.repo = repo;
    view.imageView.image = repo.image;

    return view;
}

- (IBAction)refreshRepos:(id)sender {
    self.titleField.stringValue = @"Refreshing...";
    [[NVSPackageManager sharedInstance] refresh];
    [self.tableView reloadData];
    self.titleField.stringValue = @"Repositories";
}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row {
    ViewController *preController = self.parentViewController;
    [preController browseRepo:[[[NVSPackageManager sharedInstance] sources] objectAtIndex:row]];

    return NO;
}

@end
