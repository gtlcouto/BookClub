//
//  ViewController.m
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "FriendsViewController.h"
#import "PeopleTableViewController.h"
#import "ProfileViewController.h"
#import "Person.h"
#import "AppDelegate.h"

@interface FriendsViewController () <UITableViewDataSource, UITableViewDelegate>

@property Person * user;
@property NSMutableArray * peopleArray;
@property NSMutableArray * friendsArray;
@property NSManagedObjectContext * context;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //load data from json
    self.context = [AppDelegate appDelegate].managedObjectContext;


    self.peopleArray = [NSMutableArray new];
    [self loadPeople];
    [self loadDataFromJson];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadPeople];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Person * friend = self.friendsArray[indexPath.row];
    cell.textLabel.text = friend.name;

    return cell;
}


#pragma mark - Helper methods
- (void)loadPeople
{

    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:[Person description]];
    NSSortDescriptor * sortDescriptorName = [[NSSortDescriptor alloc]initWithKey:@"suggestedBooks" ascending:YES];
    self.peopleArray =  [[self.context executeFetchRequest:request error:nil] mutableCopy];
    [self.tableView reloadData];
    self.user = self.peopleArray.firstObject;
    self.friendsArray = [[self.user.friends allObjects] mutableCopy];

}


-(void)loadDataFromJson
{
    if (self.peopleArray.count == 0)
    {
        self.user = [NSEntityDescription insertNewObjectForEntityForName:[Person description] inManagedObjectContext:self.context];
        self.user.name = @"Myself";
        [self save];
        NSURL * url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/18/friends.json"];
        NSData * myDataFromJson = [NSData dataWithContentsOfURL:url];
        NSArray * peopleArray = [NSJSONSerialization JSONObjectWithData:myDataFromJson options:0 error:nil];
        for(int i = 0; i < peopleArray.count; i++)
        {
            Person * person = [NSEntityDescription insertNewObjectForEntityForName:[Person description] inManagedObjectContext:self.context];
            person.name = peopleArray[i];
            //save
            [self save];

            //load
            [self loadPeople];
        }
    }

}

-(void)save
{
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"save from loadDataFromJson failed %@ %@", error, [error localizedDescription]);
        return;
    }
}


#pragma mark - Segue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual: @"toPeopleSegue"])
    {
        PeopleTableViewController * ptvc = segue.destinationViewController;
        ptvc.context = self.context;
    }
    else
    {
        ProfileViewController * pvc = segue.destinationViewController;
        pvc.user = self.user;
        pvc.friendsArray = self.friendsArray;
        pvc.peopleArray = self.peopleArray;
        pvc.context = self.context;
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        pvc.selectedFriend = self.friendsArray[indexPath.row];
    }
}
@end
