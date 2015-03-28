//
//  NSScheduleMainController.m
//  schedule4
//
//  Created by David Corbin on 7/28/14.
//  Copyright (c) 2014 David Corbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MinuteMinderViewController.h"

#define STATUS_BAR_HEIGHT   20
#define LEFT_BAR_WIDTH      300
#define MENU_BAR_HEIGHT     60
#define ADD_TOP_HEIGHT      50 + STATUS_BAR_HEIGHT


@implementation MinuteMinderViewController

- (void) viewDidLoad {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:NO];
    height = [[UIScreen mainScreen] applicationFrame].size.height;
    width = [[UIScreen mainScreen] applicationFrame].size.width;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoary = [paths objectAtIndex:0];
    path = [documentsDirectoary stringByAppendingPathComponent:@"data.plist"];
    fileManager = [NSFileManager defaultManager];
    
    title = [UIFont fontWithName:@"OpenSans-Bold" size:24];
    text = [UIFont fontWithName:@"OpenSans-Light" size:18];
    
    NSLog(@"%f", height);
    NSLog(@"%f", width);
    
    theme = @"bright";
    
    [super viewDidLoad];
}

//
// Start method
//
- (void) start {
    
    // Title
    UIView *scheduleview = [[UIView alloc] initWithFrame:(CGRectMake(30, STATUS_BAR_HEIGHT + 30, 300, 75))];
    scheduleview.backgroundColor = [UIColor colorWithRed:89/255.0 green:194/255.0 blue:230/255.0 alpha:1];
    /*
    UILabel *scheduletext = [[UILabel alloc] initWithFrame:(CGRectMake(50, 15, 200, 50))];
    scheduletext.text = @"MinuteMinder";
    scheduletext.font = title;
    scheduletext.textAlignment = NSTextAlignmentCenter;
    [scheduleview addSubview:scheduletext];
     */
    
    /*UIImageView *titleimg = [[[UIImageView alloc] initWithFrame:(CGRectMake(60, -20, 160, 120))] initWithImage: [UIImage imageNamed:@"logo2.png"]];
    [scheduleview addSubview:titleimg];*/
    
    
    [scheduleview.layer setShadowColor:[UIColor grayColor].CGColor];
    [scheduleview.layer setShadowOpacity:0.8];
    [scheduleview.layer setShadowRadius:5.0];
    [scheduleview.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    // Settings
    settings = [[UIView alloc] initWithFrame:CGRectMake(30, 700, 300, 50)];
    settings.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    UILabel *settingtext = [[UILabel alloc] initWithFrame:(CGRectMake(100, 0, 100, 50))];
    settingtext.text = @"Settings";
    settingtext.font = text;
    settingtext.textAlignment = NSTextAlignmentCenter;
    [settings addSubview:settingtext];
    [settings.layer setShadowColor:[UIColor grayColor].CGColor];
    [settings.layer setShadowOpacity:0.8];
    [settings.layer setShadowRadius:5.0];
    [settings.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    settings.tag = 1;
    settings.userInteractionEnabled = YES;
    
    // Events
    events = [[UIView alloc] initWithFrame:(CGRectMake(30, STATUS_BAR_HEIGHT + 140, 300, 50))];
    events.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    UILabel *eventstext = [[UILabel alloc] initWithFrame:(CGRectMake(100, 0, 100, 50))];
    eventstext.text = @"Events";
    eventstext.font = text;
    eventstext.textAlignment = NSTextAlignmentCenter;
    [events addSubview:eventstext];
    [events.layer setShadowColor:[UIColor grayColor].CGColor];
    [events.layer setShadowOpacity:0.8];
    [events.layer setShadowRadius:5.0];
    [events.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    events.tag = 2;
    events.userInteractionEnabled = YES;
    
    // Stats
    stats = [[UIView alloc] initWithFrame:(CGRectMake(30, STATUS_BAR_HEIGHT + 195, 300, 50))];
    stats.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    UILabel *statstext = [[UILabel alloc] initWithFrame:(CGRectMake(100, 0, 100, 50))];
    statstext.text = @"Stats";
    statstext.font = text;
    statstext.textAlignment = NSTextAlignmentCenter;
    [stats addSubview:statstext];
    [stats.layer setShadowColor:[UIColor grayColor].CGColor];
    [stats.layer setShadowOpacity:0.8];
    [stats.layer setShadowRadius:5.0];
    [stats.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    stats.tag = 3;
    stats.userInteractionEnabled = YES;
    
    // Header (Right)
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(390, STATUS_BAR_HEIGHT + 30, 600, 50)];
    header.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    [header.layer setShadowColor:[UIColor grayColor].CGColor];
    [header.layer setShadowOpacity:0.8];
    [header.layer setShadowRadius:5.0];
    [header.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    // Add button
    addimage = [[[UIImageView alloc] initWithFrame:(CGRectMake(540, 9, 32, 32))] initWithImage: [UIImage imageNamed:@"plus.png"]];
    addimage.tag = 4;
    addimage.userInteractionEnabled = YES;
    [header addSubview:addimage];
    
    // Edit button
    edit = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 40)];
    edit.text = @"Edit";
    edit.font = text;
    edit.tag = 5;
    edit.textAlignment = NSTextAlignmentCenter;
    edit.userInteractionEnabled = YES;
    edit.backgroundColor = [UIColor clearColor];
    [header addSubview:edit];
    
    // Body with events
    body = [[UIView alloc] initWithFrame:CGRectMake(390, 120, 600, 630)];
    body.backgroundColor = [UIColor whiteColor];
    [body.layer setShadowColor:[UIColor grayColor].CGColor];
    [body.layer setShadowOpacity:0.8];
    [body.layer setShadowRadius:5.0];
    [body.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    currentMaxPostTag = 6;
    originalPostTag = 6;
    
    [self.view addSubview:scheduleview];
    [self.view addSubview:events];
    [self.view addSubview:stats];
    
    [self.view addSubview:settings];
    
    [self.view addSubview:header];
    [self.view addSubview:body];
    
    UIImageView *full = [[[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, height, width))] initWithImage: [UIImage imageNamed:@"logo2.png"]];
    [self.view addSubview:full];
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.5f];
    full.frame = CGRectMake(89, 30, 160, 120);
    [UIView commitAnimations];
    
    [self events];
    
   
}

//
// Basic touch screen detection
//
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    // Settings
    if([touch.view tag] == 1) {
        [self settings];
        return;
    }
    
    // Events
    if ([touch.view tag] == 2) {
        [self events];
        return;
    }
    
    // Stats
    if ([touch.view tag] == 3) {
        [self stats];
        return;
    }
    
    // Add
    if ([touch.view tag] == 4) {
        [self add];
        return;
    }
    
    // Edit
    if ([touch.view tag] == 5) {
        [self edit];
        return;
    }
    
    if ([edit.text isEqualToString:@"Done"]) {
        [self remove: (int)[touch.view tag]];
    }
    else if ([touch.view tag] > originalPostTag) {
        [self check: (int)[touch.view tag]];
    }
}

//
// Settings for the app
//
- (void) settings {
    settings.backgroundColor = [UIColor colorWithRed:89/255.0 green:194/255.0 blue:230/255.0 alpha:1];
    stats.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    events.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    
    
    
    block = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, height, width)];
    [self.view addSubview:block];
    
    // Create View
    addview = [[UIView alloc] initWithFrame:CGRectMake(256, width + STATUS_BAR_HEIGHT, 512, 600)];
    addview.backgroundColor = [UIColor whiteColor];
    [addview.layer setShadowColor:[UIColor grayColor].CGColor];
    [addview.layer setShadowOpacity:0.8];
    [addview.layer setShadowRadius:5.0];
    [addview.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    UIView *navbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 512, 50)];
    navbar.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    
    [addview addSubview:navbar];
    
    // Add Event
    UILabel *settingtext = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 300, 50)];
    settingtext.text = @"Settings";
    settingtext.font = text;
    settingtext.textColor = [UIColor whiteColor];
    settingtext.textAlignment = NSTextAlignmentCenter;
    settingtext.backgroundColor = [UIColor clearColor];
    [navbar addSubview:settingtext];
    
    // Notification text
    UILabel *alerts = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 300, 30)];
    alerts.text = @"Notifications every:";
    alerts.font = text;
    alerts.textAlignment = NSTextAlignmentCenter;
    alerts.backgroundColor = [UIColor clearColor];
    [addview addSubview:alerts];
    
     UIPickerView *myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 160, 512, 400)];
     myPickerView.delegate = self;
     myPickerView.showsSelectionIndicator = YES;
     
    
    UIButton *done = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 300, 50)];
    done.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    [done addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [done setTitle:@"Close" forState:UIControlStateNormal];
    done.titleLabel.font = text;
    [addview addSubview:done];
    
    // Segmented Control for themes
    NSArray *itemArray = [NSArray arrayWithObjects: @"Bright", @"Dark", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(55, 90, 400, 25);
    //segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    
    UIColor *newSelectedTintColor = [UIColor colorWithRed:89/255.0 green:194/255.0 blue:230/255.0 alpha:1];
    [[[segmentedControl subviews] objectAtIndex:0] setTintColor:newSelectedTintColor];
    [[[segmentedControl subviews] objectAtIndex:1] setTintColor:newSelectedTintColor];
    
    [segmentedControl addTarget:self action:@selector(segmentControl:) forControlEvents: UIControlEventValueChanged];
    if ([theme isEqualToString:@"bright"]) {
        segmentedControl.selectedSegmentIndex = 0;
    }
    else {
        segmentedControl.selectedSegmentIndex = 1;
    }
    
    [addview addSubview:segmentedControl];
    
    
    // Me
    UILabel *me = [[UILabel alloc] initWithFrame:CGRectMake(100, 440, 300, 30)];
    me.text = @"Created by David Corbin";
    me.font = text;
    me.textAlignment = NSTextAlignmentCenter;
    me.backgroundColor = [UIColor clearColor];
    [addview addSubview:me];
    
    [self.view addSubview:addview];
    [addview addSubview:myPickerView];
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.6f];
    addview.frame = CGRectMake(256, ADD_TOP_HEIGHT, 512, 600);
    [UIView commitAnimations];
}

- (void)segmentControl:(UISegmentedControl *)segment {
    if(segment.selectedSegmentIndex == 0) {
        theme = @"bright";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    if(segment.selectedSegmentIndex == 1) {
        theme = @"dark";
        self.view.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    }
}

// Action for change
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%i", row);
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSUInteger numRows = 7;
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *times = @[@"6 minutes", @"7 minutes", @"10 minutes", @"15 minutes", @"20 minutes", @"30 minutes", @"60 minutes"];
    NSString *item = [times objectAtIndex:row];
    return item;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}



//
// Events for the day
//
- (void) events {
    events.backgroundColor = [UIColor colorWithRed:89/255.0 green:194/255.0 blue:230/255.0 alpha:1];
    stats.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    settings.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    
    // Remove all elements from subviews
    NSArray *elements = body.subviews;
    for (UIView *v in elements) {
        [v removeFromSuperview];
    }
    
    // Clear item array
    [itemarray removeAllObjects];
    
    // Reset the index of items
    currentMaxPostTag = originalPostTag;
    
    mode = @"events";
    
    //To reterive the data from the plist
    NSMutableDictionary *saved = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    // Array to store all the added events
    itemarray = [[NSMutableArray alloc] init];
    
    // Show empty text if there are no events
    if ([saved count] == 0) {
        UILabel *empty = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 600, 50)];
        empty.text = @"No events yet";
        empty.font = text;
        empty.textAlignment = NSTextAlignmentCenter;
        [body addSubview:empty];
        return;
    }
    
    // Show the different events
    for (int i = 1; i <= [saved count]; i++) {
        NSArray *object = [saved objectForKey:[NSString stringWithFormat:@"%i", i]];
        if ([[object objectAtIndex:2] isEqualToString:@"0"]) {
            checked = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"checkmark2.png"]];
            checked.tag = currentMaxPostTag + 1;
            checked.userInteractionEnabled = YES;
            checked.frame = CGRectMake(30, i * 35, 20, 20);
            [body addSubview:checked];
            currentMaxPostTag = currentMaxPostTag + 1;
            //NSLog(@"%d", currentMaxPostTag);
            [itemarray addObject:checked];
        }
        
        else {
            checked = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"checkmark.png"]];
            checked.tag = currentMaxPostTag + 1;
            checked.userInteractionEnabled = YES;
            checked.frame = CGRectMake(30, i * 35, 20, 20);
            [body addSubview:checked];
            currentMaxPostTag = currentMaxPostTag + 1;
            //NSLog(@"%d", currentMaxPostTag);
            [itemarray addObject:checked];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, i * 35, 500, 25)];
        label.text = [object objectAtIndex:0];
        label.font = text;
        [body addSubview:label];
    }
    
}

//
// Stats for day
//
- (void) stats {
    stats.backgroundColor = [UIColor colorWithRed:89/255.0 green:194/255.0 blue:230/255.0 alpha:1];
    events.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    settings.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    
    mode = @"stats";
    
    // Remove all elements from subviews
    NSArray *elements = body.subviews;
    for (UIView *v in elements) {
        [v removeFromSuperview];
    }
    
    //To reterive the data from the plist
    NSMutableDictionary *saved = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    //NSArray *object = [saved objectForKey:[NSString stringWithFormat:@"1"]];
    int finished = 0, notfinished = 0;
    for (int i = 1; i <= [saved count]; i++) {
        NSArray *object = [saved objectForKey:[NSString stringWithFormat:@"%i", i]];
        if ([[object objectAtIndex:2] isEqualToString:[NSString stringWithFormat:@"%i", 1]]) {
            finished = finished + 1;
        }
        else {
            notfinished = notfinished + 1;
        }
    }
    
    UILabel *ratio = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 600, 50)];
    ratio.textAlignment = NSTextAlignmentCenter;
    ratio.backgroundColor = [UIColor whiteColor];
    ratio.font = title;
    ratio.text = [NSString stringWithFormat:@"%i : %i", finished, notfinished];
    
    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 600, 40)];
    desc.textAlignment = NSTextAlignmentCenter;
    desc.backgroundColor = [UIColor whiteColor];
    desc.font = text;
    desc.text = [NSString stringWithFormat:@"Finished : Unfinished"];
    
    UILabel *fin = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 300, 50)];
    fin.backgroundColor = [UIColor whiteColor];
    fin.font = text;
    fin.text = [NSString stringWithFormat:@"%i %@ finshed", finished, finished==1?@"event":@"events"];
    
    UILabel *unfin = [[UILabel alloc] initWithFrame:CGRectMake(30, 190, 300, 50)];
    unfin.backgroundColor = [UIColor whiteColor];
    unfin.font = text;
    unfin.text = [NSString stringWithFormat:@"%i %@ unfinished", notfinished, notfinished==1?@"event":@"events"];
    
    UILabel *sum = [[UILabel alloc] initWithFrame:CGRectMake(30, 230, 300, 50)];
    sum.backgroundColor = [UIColor whiteColor];
    sum.font = text;
    sum.text = [NSString stringWithFormat:@"%i total %@", notfinished + finished, notfinished+finished==1?@"event":@"events"];
    
    UILabel *perc = [[UILabel alloc] initWithFrame:CGRectMake(30, 270, 300, 50)];
    perc.backgroundColor = [UIColor whiteColor];
    perc.font = text;
    perc.text = [NSString stringWithFormat:@"%d%% completion", (float)(finished==0?1:finished)/finished+notfinished==0?1:finished+notfinished];
    
    [body addSubview:fin];
    [body addSubview:unfin];
    [body addSubview:sum];
    [body addSubview:ratio];
    [body addSubview:desc];
    //[body addSubview:perc];
}

//
// Add button
//
- (void) add {
    
    block = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, height, width)];
    [self.view addSubview:block];
    
    // Create View
    addview = [[UIView alloc] initWithFrame:CGRectMake(256, width + STATUS_BAR_HEIGHT, 512, 600)];
    addview.backgroundColor = [UIColor whiteColor];
    [addview.layer setShadowColor:[UIColor grayColor].CGColor];
    [addview.layer setShadowOpacity:0.8];
    [addview.layer setShadowRadius:5.0];
    [addview.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
    
    UIView *navbar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 512, 50)];
    navbar.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    
    [addview addSubview:navbar];
    
    // Add Event
    UILabel *addevent = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 300, 50)];
    addevent.text = @"Add an Event";
    addevent.font = text;
    addevent.textColor = [UIColor whiteColor];
    addevent.textAlignment = NSTextAlignmentCenter;
    addevent.backgroundColor = [UIColor clearColor];
    [navbar addSubview:addevent];
    
    // Text view
    textField = [[UITextField alloc] initWithFrame:CGRectMake(53, 90, 400, 40)];
    //textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.backgroundColor = [UIColor colorWithRed:89/255.0 green:194/255.0 blue:230/255.0 alpha:1];
    //textField.borderStyle =
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"Event Name";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [addview addSubview:textField];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(106, 150, 300, 300)];
    datePicker.hidden = NO;
    datePicker.date = [NSDate date];
    
    UILabel *slidertime = [[UILabel alloc] initWithFrame:CGRectMake(0, 370, 512, 50)];
    slidertime.font = text;
    slidertime.textAlignment = NSTextAlignmentCenter;
    slidertime.text = @"Event duration";
    [addview addSubview:slidertime];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(60, 420, 400, 30)];
    slider.maximumValue = 720;
    slider.minimumValue = 1;
    slider.value = 10;
    [slider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [addview addSubview:slider];
    
    time = [[UILabel alloc] initWithFrame:CGRectMake(0, 430, 512, 50)];
    time.font = text;
    time.textAlignment = NSTextAlignmentCenter;
    time.text = @"10 min";
    [addview addSubview:time];
    
    add = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 100, 50)];
    add.backgroundColor = [UIColor colorWithRed:89/255.0 green:194/255.0 blue:230/255.0 alpha:1];
    [add addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
    [add setTitle:@"Add" forState:UIControlStateNormal];
    add.titleLabel.font = text;
    [addview addSubview:add];
    
    UIButton *close = [[UIButton alloc] initWithFrame:CGRectMake(300, 500, 100, 50)];
    close.backgroundColor = [UIColor colorWithRed:79/255.0 green:95/255.0 blue:111/255.0 alpha:1];
    [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [close setTitle:@"Close" forState:UIControlStateNormal];
    close.titleLabel.font = text;
    [addview addSubview:close];
    
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [addview addSubview:datePicker];
    
    [self.view addSubview:addview];
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.6f];
    addview.frame = CGRectMake(256, ADD_TOP_HEIGHT, 512, 600);
    [UIView commitAnimations];
    
}

//
// Catch slider change
//
- (void)sliderValueDidChange:(UISlider *)slider {
    NSString *real = [self convert:slider.value];
    //time.text = [NSString stringWithFormat:@"%i min", (int)slider.value];
    time.text = [NSString stringWithFormat:@"%@", real];
}

//
// Convert to human readable format
//
- (NSString *) convert:(float) minutes {
    int min = (int) minutes;
    NSLog(@"%i min", min);
    // Less than an hour
    if (min < 60) {
        return [NSString stringWithFormat:@"%i minutes", min];
    }
    // Less than a day
    else if (min < 24 * 60) {
        int new = min / 60;
        return [NSString stringWithFormat:@"%i hours", new];
    }
    // Less than a year
    else if (min < 518400) {
        int new = min / 1440;
        return [NSString stringWithFormat:@"%i days", new];
    }
    else {
        return @"More than a year";
    }
}

//
// Catch keyboard close
//
- (BOOL) textFieldShouldReturn: (UITextField *) textfield {
    if (textfield == textField) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

//
// Change the date
//
- (void)dateChange:(id)sender{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    //NSLog(@"%@", [df stringFromDate: datePicker.date]);
}

//
// Add Event Button
//
- (void) addEvent {
    // Check if string is empty
    if ([textField.text isEqualToString:@""]) {
        NSLog(@"no text");
        return;
    }
    
    NSDate *today = [NSDate date];
    NSComparisonResult result = [today compare:datePicker.date];
    // Validate date against current date
    if (result == NSOrderedAscending) {
        NSLog(@"Date ahead of time");
    }
    else if (result == NSOrderedDescending) {
        add.backgroundColor = [UIColor redColor];
        return;
    }
    else {
        NSLog(@"Same date");
    }
    
    NSMutableDictionary *data;
    
    // Check if file exists
    if ([fileManager fileExistsAtPath: path]) {
        data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    }
    else {
        data = [[NSMutableDictionary alloc] init];
    }
    
    NSArray *new = @[textField.text, datePicker.date, @"0"];
    int count = [data count] + 1.0;
    NSLog(@"Count: %i", count);
    [data setObject:new forKey:[NSString stringWithFormat:@"%i", count]];
    
    // Write to file
    [data writeToFile:path atomically:YES];
    
    [self notify:datePicker.date name:textField.text];
    
    [self close];
    return;
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alert) name:UIWindowDidBecomeKeyNotification object:nil];
    
    
    NSLog(@"%@", itemarray);
}

//
// Edit Button
//
- (void) edit {
    
    // Only edit events for
    if (![mode isEqualToString:@"events"]) {
        return;
    }
    
    // Check if edit is already open
    if ([edit.text isEqualToString:@"Done"]) {
        [addimage setHidden:NO];
        edit.text = @"Edit";
        return [self events];
    }
    
    edit.text = @"Done";
    [addimage setHidden:YES];
    
    // Remove all elements from subviews
    NSArray *elements = body.subviews;
    for (UIView *v in elements) {
        [v removeFromSuperview];
    }
    
    // Clear item array
    [itemarray removeAllObjects];
    
    // Reset the index of items
    currentMaxPostTag = originalPostTag;
    
    //To reterive the data from the plist
    NSMutableDictionary *saved = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    // Array to store all the added events
    itemarray = [[NSMutableArray alloc] init];
    
    // Show empty text if there are no events
    if ([saved count] == 0) {
        UILabel *empty = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 600, 50)];
        empty.text = @"No events yet";
        empty.font = text;
        empty.textAlignment = NSTextAlignmentCenter;
        [body addSubview:empty];
        return;
    }
    
    // Show the different events
    for (int i = 1; i <= [saved count]; i++) {
        NSArray *object = [saved objectForKey:[NSString stringWithFormat:@"%i", i]];
        
        checked = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"close.png"]];
        checked.tag = currentMaxPostTag + 1;
        checked.userInteractionEnabled = YES;
        checked.frame = CGRectMake(30, i * 35, 20, 20);
        [body addSubview:checked];
        currentMaxPostTag = currentMaxPostTag + 1;
        [itemarray addObject:checked];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, i * 35, 500, 25)];
        label.text = [object objectAtIndex:0];
        label.font = text;
        [body addSubview:label];
    }
}

//
// Close add window
//
- (void) close {
    NSLog(@"close");
    // Remove add view
    [block removeFromSuperview];
    
    [UIView beginAnimations:@"MoveView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.6f];
    addview.frame = CGRectMake(256, width + STATUS_BAR_HEIGHT, 512, 600);
    [UIView commitAnimations];
    
    [self performSelector:@selector(rem) withObject:self afterDelay:0.6];
    
    [self reset];
}

- (void) rem {
    [addview removeFromSuperview];
}

//
// Reset the main view after a subview goes away
//
- (void) reset {
    NSLog(@"reset");
    if ([mode isEqualToString:@"events"]) {
        [self events];
    }
    
    if ([mode isEqualToString:@"stats"]) {
        [self stats];
    }
}

//
// Finish an event
//
- (void) check: (int) touchtag {
    NSMutableDictionary *saved = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSMutableArray *object = [saved objectForKey:[NSString stringWithFormat:@"%i", touchtag - originalPostTag]];
    
    // Check if the checkmark is already filled
    if ([[object objectAtIndex:2] isEqualToString:@"1"]) {
        return;
    }
    
    UIImage *nowchecked = [UIImage imageNamed: @"checkmark.png"];
    [[itemarray objectAtIndex:touchtag - originalPostTag - 1] setImage:nowchecked];
    
    // Change 0 to 1
    [object replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%i", 1]];
    [saved setObject:object forKey:[NSString stringWithFormat:@"%i", touchtag - originalPostTag]];
    [saved writeToFile:path atomically:YES];
}

//
// Remove an event
//
- (void) remove: (int) touchtag {
    NSMutableDictionary *saved = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    //NSMutableArray *object = [saved objectForKey:[NSString stringWithFormat:@"%i", touchtag - originalPostTag]];
    
    //[object removeObjectAtIndex:1];
    //[saved setObject:object forKey:[NSString stringWithFormat:@"%i", touchtag - originalPostTag]];
    
    [saved removeObjectForKey:[NSString stringWithFormat:@"%i", touchtag - originalPostTag]];
    [saved writeToFile:path atomically:YES];
    
    [self correctIndex];
    
    edit.text = @"Edit";
    [addimage setHidden:NO];
    [self events];
}

//
// Corrent main plist index
//
- (void) correctIndex {
    NSMutableDictionary *saved = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    NSMutableDictionary *cpy = [[NSMutableDictionary alloc] init];
    NSLog(@"%@", saved);
    int i = 1;
    for (NSString *key in saved) {
        id objectToPreserve = [saved objectForKey:key];
        [cpy setObject:objectToPreserve forKey:[NSString stringWithFormat:@"%i", i]];
        i = i + 1;
    }
    [cpy writeToFile:path atomically:YES];
}

//
// Set notification
//
- (void) notify:(NSDate *)date name:(NSString *)name {
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.alertBody = name;// . @"has started";
    localNotification.alertAction = @"Show me the item";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

//
// Debug alert test method
//
- (void) alert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"test alert" message: @"is cool" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end