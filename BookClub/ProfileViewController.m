//
//  ProfileViewController.m
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "ProfileViewController.h"
#import "AddBookViewController.h"
#import "BookViewController.h"
#import "Book.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *booksLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray * booksArray;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)viewWillAppear:(BOOL)animated
{
    self.booksArray = [[self.selectedFriend.suggestedBooks allObjects] mutableCopy];
    [self.tableView reloadData];
    [self reloadUI];
}

-(void)reloadUI
{
    self.nameLabel.text = self.selectedFriend.name;
    self.booksLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.selectedFriend.suggestedBooks.count] ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectedFriend.suggestedBooks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Book * book = [self.booksArray objectAtIndex:indexPath.row];
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text = book.author;

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier  isEqual: @"toAddBook"]){
        AddBookViewController * vc = segue.destinationViewController;
        vc.context = self.context;
        vc.selectedFriend  = self.selectedFriend;
    } else
    {
        BookViewController * vc = segue.destinationViewController;
        vc.context = self.context;
        vc.selectedBook = self.booksArray[[self.tableView indexPathForSelectedRow].row];
        vc.indexpathRowForSelectedObject = [self.tableView indexPathForSelectedRow].row;
        
    }
}
@end
