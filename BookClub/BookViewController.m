//
//  BookViewController.m
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "BookViewController.h"
#import "Comment.h"

@interface BookViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray * booksArray;
@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.selectedBook.title;
    self.authorLabel.text = self.selectedBook.author;
    [self loadComments];

}
- (IBAction)onAddCommentButtonPressed:(id)sender {
    UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"Leave a comment!" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertcontroller addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        nil;
    }];

    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"Okay"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   UITextField * textField = alertcontroller.textFields.firstObject;
                                   Comment * comment = [NSEntityDescription insertNewObjectForEntityForName:[Comment description] inManagedObjectContext:self.context];
                                   comment.text = textField.text;
                                   [self.selectedBook addCommentsObject:comment];

                                   NSError *error = nil;
                                   if (![self.context save:&error]) {
                                       NSLog(@"Failed to add comment!! %@ %@", error, [error localizedDescription]);
                                       return;
                                   }
                                   [self loadComments];

                               }];
    
    [alertcontroller addAction:okAction];
    
    [self presentViewController:alertcontroller animated:YES completion:^{
        nil;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.selectedBook.comments allObjects].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Comment * comment = [[self.selectedBook.comments allObjects] objectAtIndex:indexPath.row];
    cell.textLabel.text = comment.text;

    return cell;
}

- (void)loadComments
{
        NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
        self.booksArray =  [self.context executeFetchRequest:request error:nil];
        self.selectedBook = [self.booksArray  objectAtIndex:self.indexpathRowForSelectedObject];
        [self.tableView reloadData];


}


@end
