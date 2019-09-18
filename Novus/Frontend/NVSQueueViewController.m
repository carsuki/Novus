//
//  NVSQueueViewController.m
//  Novus
//
//  Created by EvenDev on 18/09/2019.
//  Copyright © 2019 Polar Team. All rights reserved.
//

#import "NVSQueueViewController.h"

@interface NVSQueueViewController ()

@end

@implementation NVSQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (IBAction)clear:(id)sender {
    [[NVSQueue sharedInstance] clear];
    [self.tableView reloadData];
}

- (IBAction)next:(id)sender {
    [self performSegueWithIdentifier:@"nextQueue" sender:self];
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    NVSLogViewController *controller = segue.destinationController;
    controller.command = @"apt update";
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [[NVSQueue sharedInstance] actions].count;
}

-(NSView*)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NVSQueueCellView *view = [tableView makeViewWithIdentifier:@"queueCell" owner:self];
    NVSQueueAction *action = [[[NVSQueue sharedInstance] queueActions] objectAtIndex:row];
    if (action.package.name) {
        view.textField.stringValue = action.package.name;
    } else {
        view.textField.stringValue = action.package.identifier;
    }
    if (action.action == 0) {
        view.secondaryTextField.stringValue = @"Install";
    } else if (action.action == 1) {
        view.secondaryTextField.stringValue = @"Remove";
    } else if (action.action == 2) {
        view.secondaryTextField.stringValue = @"Reinstall";
    } else {
        view.secondaryTextField.stringValue = @"Unknown";
    }
    view.imageView.image = action.package.icon;
    return view;
}

@end
