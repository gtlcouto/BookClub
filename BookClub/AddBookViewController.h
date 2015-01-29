//
//  AddBookViewController.h
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface AddBookViewController : UIViewController

@property NSManagedObjectContext * context;
@property Person * selectedFriend;

@end
