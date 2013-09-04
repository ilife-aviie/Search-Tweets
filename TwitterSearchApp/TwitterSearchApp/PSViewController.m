//
//  PSViewController.m
//  TwitterSearchApp
//
//  Created by DJ on 02/09/13.
//  Copyright (c) 2013 AvinashNehra. All rights reserved.
//

#import "PSViewController.h"
#import "PSSearchListController.h"

@interface PSViewController ()

@end

@implementation PSViewController

-(id) init
{
    self = [super init];
    if (self) {
        _accountStore = [[ACAccountStore alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)twitterSearchLogin:(id)sender
{
    // Getting access to twitter account.
    self.accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [self.accountStore requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {
        if(granted)
        {
            NSArray *twitterAccounts = [self.accountStore accountsWithAccountType:twitterAccountType];
            self.twitterAccount = [twitterAccounts lastObject];
            [self pushView];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Access to twitter account failed. Please setup account in Settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert show];
            });           
        }
    }];    
}


-(void) pushView
{
    PSSearchListController *secondView = [[PSSearchListController alloc] initWithNibName:@"PSSearchListController" bundle:nil];    
    [self presentViewController:secondView animated:YES completion:nil];    
}

@end
