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
    if ([[[NVSQueue sharedInstance] queueActions] count] > 0) {
        [self performSegueWithIdentifier:@"nextQueue" sender:self];
    }
}

-(void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
    NSMutableArray *install = [NSMutableArray new];
    NSMutableArray *remove = [NSMutableArray new];
    [[[NVSQueue sharedInstance] queueActions] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NVSQueueAction *action = obj;
        if (action.action == 0) {
            [install addObject:action.package.identifier];
        } else if (action.action == 1) {
            [remove addObject:action.package.identifier];
        }
    }];
    NSString *installCmd = [NSString stringWithFormat:@"unbuffer apt-get -y install %@", [install componentsJoinedByString:@" "]];
    NSString *removeCmd = [NSString stringWithFormat:@"unbuffer apt-get -y remove %@", [remove componentsJoinedByString:@" "]];
    NSString *cmd = [NSString new];
    if (install.count > 0 && remove.count > 0) {
        cmd = [NSString stringWithFormat:@"%@ && %@", installCmd, removeCmd];
    } else if (install.count > 0 && remove.count < 1) {
        cmd = installCmd;
    } else if (install.count < 1 && remove.count > 0) {
        cmd = removeCmd;
    }
    [[NSUserDefaults standardUserDefaults] setObject:cmd forKey:@"command"];
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
