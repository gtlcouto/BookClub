//
//  BookViewController.h
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookViewController : UIViewController

@property NSManagedObjectContext * context;
@property Book * selectedBook;
@property NSInteger indexpathRowForSelectedObject;

@end
