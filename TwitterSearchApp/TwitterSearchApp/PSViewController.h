//
//  PSViewController.h
//  TwitterSearchApp
//
//  Created by DJ on 02/09/13.
//  Copyright (c) 2013 AvinashNehra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>


@interface PSViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic) ACAccountStore *accountStore;
@property (nonatomic, retain) ACAccount *twitterAccount;

-(IBAction)twitterSearchLogin:(id)sender;

@end
