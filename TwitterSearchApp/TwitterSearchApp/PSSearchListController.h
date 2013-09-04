//
//  PSSearchListController.h
//  TwitterSearchApp
//
//  Created by DJ on 03/09/13.
//  Copyright (c) 2013 AvinashNehra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>



@interface PSSearchListController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *searchTerm;
@property (weak, nonatomic) IBOutlet UITableView *tweets;

-(IBAction)buttonPressed:(id)sender;

@end
