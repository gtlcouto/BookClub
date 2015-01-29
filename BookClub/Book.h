//
//  Book.h
//  BookClub
//
//  Created by Gustavo Couto on 2015-01-28.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSData * cover;
@property (nonatomic, retain) NSSet *peopleWithBook;
@property (nonatomic, retain) NSSet *comments;
@end

@interface Book (CoreDataGeneratedAccessors)

- (void)addPeopleWithBookObject:(NSManagedObject *)value;
- (void)removePeopleWithBookObject:(NSManagedObject *)value;
- (void)addPeopleWithBook:(NSSet *)values;
- (void)removePeopleWithBook:(NSSet *)values;

- (void)addCommentsObject:(NSManagedObject *)value;
- (void)removeCommentsObject:(NSManagedObject *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end
