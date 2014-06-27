//
//  RNShareViewController.m
//  Recipe Network
//
//  Created by Guy Ben Aharon on 6/24/14.
//  Copyright (c) 2014 Guyb. All rights reserved.
//

#import "RNShareViewController.h"

@interface RNShareViewController (){
UIActivityIndicatorView *spinner;
}
@end

@implementation RNShareViewController

@synthesize tblTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Sets top title text
    [self.navigationItem setTitle:@"Share RecipeNetwork"];
    
    // Starts spinner animation for loading contacts
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(170, 120);
    spinner.hidesWhenStopped = YES;
    [self.tblTableView addSubview:spinner];
    [spinner startAnimating];
    
    // Gets contacts and display them on table view
    [self askPermsAndGetContacts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(IBAction)sendClick:(id)sender
{
    // Couldnt open SMS app cause there isnt in free simulator
    // Instade display a message box to indicate user
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not implemented" message:@"Could not implement due to Apple free simulator limitations." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [contactsData count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"contactCell";
    
    // Gets reusable cell if exists
    RNContactTableViewCell *cell = (RNContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier  forIndexPath:indexPath];
    
    // if not exists creates it
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Get contact for the row ID and sets cells labels by it
    RNContact *contact = (RNContact *)[contactsData objectAtIndex:indexPath.row];
    [cell.lblName setText:contact.name];
    [cell.lblNumber setText:contact.phoneNumber];
    
    return cell;
}

-(void) askPermsAndGetContacts
{
    CFErrorRef error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    // Checks if the app gots permissions for accessing contacts
    if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        // if didnt ask before, asks for permissions
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
            if(granted == YES)
            {
                // Sets address book
                [self setContactsSource:addressBook];
                
                // Release contacts resources
                CFRelease(addressBook);
                
                // Reloads table view
                [self.tblTableView reloadData];
            }
            else
            {
                // If access denied, display appropriate message box
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authorization failed" message:@"Please approve us access you contact list." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            // Stops spinner after contacts was loaded
            [spinner stopAnimating];
    });
    }
    else if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        // If already authorized, just sets the address book
        [self setContactsSource:addressBook];
        
        // Release contacts resources
        CFRelease(addressBook);
        
        // Reloads table view
        [self.tblTableView reloadData];
        
        // Stops spinner after contacts was loaded
        [spinner stopAnimating];
    }
    else
    {
        // If access denied from previous runnings, shows appropriate message box
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authorization failed" message:@"Please approve us access you contact list." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        // Stops spinner
        [spinner stopAnimating];
    }
}

-(void) setContactsSource :(ABAddressBookRef) addressBook
{
    // Loads address books list
    CFErrorRef error = nil;
    addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
    CFArrayRef allPeopleRef = ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName);
    NSArray *allPeople = (__bridge_transfer NSArray *)allPeopleRef;
    CFIndex count = ABAddressBookGetPersonCount(addressBook);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    
    // Run over the list to set attributes
    for(int index = 0; index < count; index++)
    {
        // Creates RNContact object
        RNContact *contact = [[RNContact alloc] init];
        
        // Get record from address book by index
        ABRecordRef record = (__bridge ABRecordRef)[allPeople objectAtIndex:index];
        
        // Get first name and last name properties from the record
        CFTypeRef firstName =ABRecordCopyValue(record, kABPersonFirstNameProperty);
        CFTypeRef lastName =ABRecordCopyValue(record, kABPersonLastNameProperty);
        
        // Handles cases which one of them is empty
        if(firstName != NULL && lastName != NULL)
        {
            contact.name = [NSString stringWithFormat:@"%@ %@",ABRecordCopyValue(record, kABPersonFirstNameProperty), ABRecordCopyValue(record, kABPersonLastNameProperty)];
            CFRelease(firstName);
            CFRelease(lastName);
        }
        else if(firstName != NULL)
        {
            contact.name = [NSString stringWithFormat:@"%@",firstName];
            CFRelease(firstName);
        }
        else if(lastName != NULL)
        {
            contact.name = [NSString stringWithFormat:@"%@",lastName];
            CFRelease(lastName);
        }
        else
        {
            contact.name = @"None";
        }
        
        // Gets phones from record
        ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
        
        // If got any phones, takes the first one
        if(ABMultiValueGetCount(phones) > 0)
        {
            CFTypeRef typeRef = ABMultiValueCopyValueAtIndex(phones, 0);
            contact.phoneNumber = (__bridge NSString *)typeRef;
            CFRelease(typeRef);
        }
        else
        {
            contact.phoneNumber = @"None";
        }
        
        // Release contacts resources
        CFRelease(phones);
        CFRelease(record);
        
        [array addObject:contact];
    }
    
    contactsData = array;
    
    // Release contacts resources
    CFRelease(allPeopleRef);
    CFRelease(source);
}

@end
