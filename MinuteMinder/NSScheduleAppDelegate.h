//
//  NSScheduleAppDelegate.h
//  MinuteMinder
//
//  Created by David Corbin on 8/7/14.
//  Copyright (c) 2014 David Corbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSScheduleAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
