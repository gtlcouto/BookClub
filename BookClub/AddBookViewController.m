//
//  AddBookViewController.m
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "AddBookViewController.h"
#import "Book.h"

@interface AddBookViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property NSMutableArray * booksArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray * suggestedBooks;

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    self.suggestedBooks = [NSMutableArray new];
    self.booksArray = [NSMutableArray new];
    [self loadBooks];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onAddBookButtonPressed:(id)sender {

     Book * book = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:self.context];
    book.title = self.titleTextField.text;
    book.author = self.authorTextField.text;

    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Failed to add adventurer!! %@ %@", error, [error localizedDescription]);
        return;
    }
    [self loadBooks];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.booksArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Book * book = [self.booksArray objectAtIndex:indexPath.row];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;

    if ([self.selectedFriend.suggestedBooks containsObject:book]) {
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
    Book * book = [self.booksArray objectAtIndex:indexPath.row];

    if([self.selectedFriend.suggestedBooks containsObject:book])
    {
        [self.selectedFriend removeSuggestedBooksObject:book];
    }
    else
    {
        [self.selectedFriend addSuggestedBooksObject:book];
    }


    [self.context save:nil];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (void)loadBooks
{

    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:[Book description]];
    self.booksArray =  [[self.context executeFetchRequest:request error:nil] mutableCopy];
    self.suggestedBooks = [[self.selectedFriend.suggestedBooks allObjects] mutableCopy];
    NSArray * tempArray = [self.booksArray copy];
    if(tempArray){
        for (Book *book in tempArray) {
            if ([self.suggestedBooks containsObject:book]) {
                [self.booksArray removeObject:book];
            }
        }
    }
    [self.tableView reloadData];
}


@end
