//
//  SellVC.m
//  tix4u
//
//  Created by Merritt Tidwell on 10/8/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import "SellVC.h"
#import "MapVC.h"
#import <Parse/Parse.h>

@interface SellVC ()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation SellVC {
    
    NSArray * _numberOfTicket;
    NSArray * _row;
    NSArray * _section;
    NSDate *  _eventDate;
    NSArray * _eventName;
    NSString * selectedTicket;
    NSString * selectedRow;
    NSString * selectedEvent;
    NSString * selectedSection;
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
  
//Ticket Picker
    self.ticketPicker = [[UIPickerView alloc]initWithFrame:(CGRectMake(120, 55, 50, 50))];
    self.ticketPicker.showsSelectionIndicator = YES;
    _numberOfTicket = @[@"1",@"2",@"3",@"4"];
    self.ticketPicker.delegate = self;
    self.ticketPicker.dataSource = self;
    self.ticketPicker.tag = 0;
    [self.view addSubview:self.ticketPicker];
    
//Ticket Label
   
    UILabel * ticketLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 55, 100, 60)];
    ticketLabel.text = @"Tickets";
    ticketLabel.textColor = [UIColor redColor];
    ticketLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
    [self.view addSubview:ticketLabel];
    
  
// Section Picker
    self.sectionPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(215, 175, 50, 50)];
    self.sectionPicker.showsSelectionIndicator = YES;
    _section= @[@"500", @"700"];
    self.sectionPicker.delegate = self;
    self.sectionPicker.dataSource = self;
    self.sectionPicker.tag = 1;
    [self.view addSubview:self.sectionPicker];
    
// Section Label
    
    UILabel * sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 185, 80, 50)];
    sectionLabel.text = @"Section";
    sectionLabel.textColor = [UIColor redColor];
    [self.view addSubview:sectionLabel];
    
 
 
// Row Picker
    
    
    self.rowPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(45, 175, 50, 50)];
    self.rowPicker.showsSelectionIndicator = YES;
    _row= @[@"1", @"3"];
    self.rowPicker.delegate = self;
    self.rowPicker.dataSource = self;
    self.rowPicker.tag = 2;
    [self.view addSubview:self.rowPicker];
    
//Row Label
    
    UILabel * rowLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 185, 50, 50)];
    rowLabel.text = @"Row";
    rowLabel.textColor = [UIColor redColor];
    [self.view addSubview:rowLabel];
    
//Event Picker
    
    self.eventPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(60, 350, 200, 50)];
    self.eventPicker.showsSelectionIndicator = YES;
    _eventName = @[@"other", @"another place", @"other", @"this one produce something"];

    self.eventPicker.delegate = self;
    self.eventPicker.dataSource = self;
    self.eventPicker.tag = 3;
    [self.view addSubview:self.eventPicker];
    
//Event Label
    UILabel * eventLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 370, 200, 50)];
    eventLabel.text = @"Choose Your Event";
    eventLabel.textColor = [UIColor redColor];
   [self.view addSubview:eventLabel];
    
    }

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}


-(void)showTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"other Venue";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    
    [self.view addSubview:textField];
    
    
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIPickerView Delegate

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 0:
            
            return   _numberOfTicket.count;
            break;
            
        case 1:
            
            return   _section.count;
            break;
            
        case 2:
            return   _row.count;
            break;
       
        case 3:
            
            return  _eventName.count;
            break;
            
            
        default:
            break;
    }
    
    return 0;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component

{
    switch (pickerView.tag) {
        case 0:
            
            return  _numberOfTicket[row];
            break;
            
        case 1:
            
            return _section[row];
            break;
       
        case 2:
            return _row[row];
            break;
        
        case 3:
            
            return _eventName[row];
            break;
            
        default:
            break;
    }
    
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"%d", (int)pickerView.tag);
    switch (pickerView.tag) {
        case 0:
            
            selectedTicket =  _numberOfTicket[row];
            break;
            
        case 1:
            
            selectedSection = _section[row];
            break;
            
        case 2:
            selectedRow = _row[row];
            break;
      
        case 3:
            
            selectedEvent = _eventName[row];
            NSLog(@"%@", selectedEvent);
            
            break;
            
        default:
            break;
    }
    
    if ([self.eventPicker selectedRowInComponent:0] == 3)
    {
        [self showTextField];
    }
    else if (([self.ticketPicker selectedRowInComponent:0] && [self.rowPicker selectedRowInComponent:0] && [self.eventPicker selectedRowInComponent:0]) > 0)
    {
        NSLog(@"self ticker running");
        MapVC * mapVC = [[MapVC alloc]init];
        mapVC.view.backgroundColor = [UIColor clearColor];
        [self presentViewController: mapVC animated:YES completion:nil];
        [self saveToParseSell];
       
    }
    
    }

-(void)saveToParseSell
{
    PFObject * sellerInfo = [PFObject objectWithClassName:@"Selling"];
    [sellerInfo setObject: selectedTicket forKey:@"NumberOfTicketsSelling"];
    [sellerInfo setObject: selectedEvent forKey:@"Event"];
    [sellerInfo setObject: selectedRow forKey:@"Row"];
    [sellerInfo setObject: selectedSection forKey:@"Section"];
    // [sellerInfo setObject:_eventDate forKey:@"Date"];
    NSLog(@"save to parseseller");
    
    [sellerInfo setObject:[PFUser currentUser].objectId forKey:@"SellerID"];
    
    [sellerInfo saveInBackground];
    
}




@end