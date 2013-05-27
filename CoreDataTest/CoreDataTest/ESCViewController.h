//
//  ESCViewController.h
//  CoreDataTest
//
//  Created by David Linsin on 5/27/13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESCViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) IBOutlet UILabel *generateLabel;
@property(nonatomic, strong) IBOutlet UITextField *searchField;
@property(nonatomic, strong) IBOutlet UILabel *searchLabel;
@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic, strong) IBOutlet UISwitch *local;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic, strong) NSArray *resultVals;


- (IBAction)generate:(id)sender;

@end
