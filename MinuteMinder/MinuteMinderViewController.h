//
//  MinuteMinderViewController.h
//  MinuteMinder
//
//  Created by David Corbin on 8/7/14.
//  Copyright (c) 2014 David Corbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinuteMinderViewController : UIViewController {
    UIFont *title;
    UIFont *text;
    
    UILabel *time;
    
    NSString *theme;
    
    UIImageView *addimage;
    
    UILabel *edit;
    
    UIView *events;
    UIView *stats;
    UIView *settings;
    UIView *body;
    
    NSString *mode;
    
    CGFloat height;
    CGFloat width;
    
    UIView *addview;
    UIView *block;
    
    NSString *path;
    NSFileManager *fileManager;
    
    UIDatePicker *datePicker;
    UITextField *textField;
    
    UIButton *add;
    
    UIImageView *checked;
    
    NSMutableArray *itemarray;
    
    int currentMaxPostTag;
    int originalPostTag;
}

- (void) start;
@property (readwrite, nonatomic) NSMutableArray *array;

@end

