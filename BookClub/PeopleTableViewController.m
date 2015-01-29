//
//  PeopleTableViewController.m
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "PeopleTableViewController.h"
#import "Person.h"
#import "AppDelegate.h"

@interface PeopleTableViewController ()

@property Person * user;
@property NSMutableArray * peopleArray;
@property NSMutableArray * friendsArray;

@end

@implementation PeopleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.peopleArray = [NSMutableArray new];
    self.friendsArray = [NSMutableArray new];
    [self loadPeople];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.peopleArray.count - 1; //removing yourself
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Person * person = self.peopleArray[indexPath.row + 1];
    cell.textLabel.text = person.name;
    if ([self.user.friends containsObject:person]) {
         cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
         cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = self.peopleArray[indexPath.row + 1];

    if([self.user.friends containsObject:person])
    {
        [self.user removeFriendsObject:person];
    }
    else
    {
        [self.user addFriendsObject:person];
    }


    [self.context save:nil];
    [self.tableView reloadData];
}

#pragma mark - Helper methods
- (void)loadPeople
{

    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:[Person description]];
    self.peopleArray =  [[self.context executeFetchRequest:request error:nil] mutableCopy];
    self.user = self.peopleArray.firstObject;
    self.friendsArray = [[self.user.friends allObjects] mutableCopy];
    [self.tableView reloadData];
    
}

@end
