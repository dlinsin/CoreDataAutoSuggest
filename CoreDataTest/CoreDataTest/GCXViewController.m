//
//  GCXViewController.m
//  CoreDataTest
//
//  Created by David Linsin on 5/27/13.
//  Copyright (c) 2013 grandcentrix GmbH. All rights reserved.
//

#import "GCXViewController.h"
#import "Name.h"

@interface GCXViewController ()

@property(nonatomic, strong) NSArray *localDB;
@end

@implementation GCXViewController

@synthesize generateLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultVals = [NSArray array];
    NSData *generateData = [[NSData alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"generate" ofType:@"txt"]];
            NSString *generateStr = [[NSString alloc] initWithData:generateData encoding:NSUTF8StringEncoding];
            self.localDB = [generateStr componentsSeparatedByString:@"\n"];
    NSLog(@"Loaded %d entries", [self.localDB count]);
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)generate:(id)sender {
    [Name MR_truncateAll];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *generateData = [[NSData alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"generate" ofType:@"txt"]];
        NSString *generateStr = [[NSString alloc] initWithData:generateData encoding:NSUTF8StringEncoding];
        NSArray *words = [generateStr componentsSeparatedByString:@"\n"];
        [self generateDBEntries:words];
    });
}

- (void)generateDBEntries:(NSArray *)words {
    __block NSTimeInterval start = [[NSDate date] timeIntervalSince1970];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    context.MR_workingName = @"Create Entries";

    NSMutableArray *entries = [NSMutableArray array];
    for (int j = 0; j < [words count] - 1; j++) {
        Name *tmp = [Name MR_createEntity];
        tmp.identValue = j;
        tmp.name = [words objectAtIndex:j];
        tmp.desc = [words objectAtIndex:j];
        [entries addObject:tmp];
        if ((j % 100) == 0) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.generateLabel.text = [NSString stringWithFormat:@"Generating %d", j];
            });
        }
    }

    [context MR_saveNestedContextsErrorHandler:nil completion:^{
        NSLog(@"Insert took %d", (int) ([[NSDate date] timeIntervalSince1970] - start));
    }];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.local.on) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doSearchLocally) object:nil];
        [self performSelector:@selector(doSearchLocally) withObject:nil afterDelay:0.2];
    } else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doSearch) object:nil];
        [self performSelector:@selector(doSearch) withObject:nil afterDelay:0.3];
    }
    return YES;
}

- (void)doSearch {
    [self.activityIndicator startAnimating];
    __block NSString *text = self.searchField.text;
    NSLog(@"Starting search for %@", text);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@", [text uppercaseString]];
        NSArray *vals = [Name MR_findAllWithPredicate:predicate];
        self.resultVals = vals;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            self.searchLabel.text = [NSString stringWithFormat:@"Found: %d items", [vals count]];
            [self.activityIndicator stopAnimating];
            NSLog(@"Finished search %@", text);
        });
    });
}

- (void)doSearchLocally {
    [self.activityIndicator startAnimating];
    __block NSString *text = [self.searchField.text uppercaseString];
    NSLog(@"Starting search for %@", text);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSMutableArray *vals = [NSMutableArray array];
        for (NSString *name in self.localDB) {
            if ([name hasPrefix:text]) {
                [vals addObject:name];
            }
        }
        self.resultVals = vals;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            self.searchLabel.text = [NSString stringWithFormat:@"Found: %d items", [vals count]];
            [self.activityIndicator stopAnimating];
            NSLog(@"Finished search %@", text);
        });
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.resultVals count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }

    if (self.local.on) {
        cell.textLabel.text = [self.resultVals objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = ((Name *)[self.resultVals objectAtIndex:indexPath.row]).name;
    }

    return cell;
}


@end
