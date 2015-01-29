//
//  ProfileViewController.h
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface ProfileViewController : UIViewController
@property Person * user;
@property Person * selectedFriend;
@property NSMutableArray * peopleArray;
@property NSMutableArray * friendsArray;
@property NSManagedObjectContext * context;
@end
