//
//  Person.h
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book, Person;

@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *suggestedBooks;
@property (nonatomic, retain) NSSet *friends;
@end

@interface Person (CoreDataGeneratedAccessors)

- (void)addSuggestedBooksObject:(Book *)value;
- (void)removeSuggestedBooksObject:(Book *)value;
- (void)addSuggestedBooks:(NSSet *)values;
- (void)removeSuggestedBooks:(NSSet *)values;

- (void)addFriendsObject:(Person *)value;
- (void)removeFriendsObject:(Person *)value;
- (void)addFriends:(NSSet *)values;
- (void)removeFriends:(NSSet *)values;

@end
