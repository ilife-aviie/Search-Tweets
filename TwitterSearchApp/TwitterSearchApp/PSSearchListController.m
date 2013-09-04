//
//  PSSearchListController.m
//  TwitterSearchApp
//
//  Created by DJ on 03/09/13.
//  Copyright (c) 2013 AvinashNehra. All rights reserved.
//

#import "PSSearchListController.h"
#import "PSAppDelegate.h"
#import "PSViewController.h"
#import "PSSearchListDataParser.h"
#import "PStwitterCell.h"

@interface PSSearchListController ()
{
    NSArray *tweetsData;
}

@end

@implementation PSSearchListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];       
    self.searchTerm.clearsOnBeginEditing = YES;
}


-(IBAction)buttonPressed:(id)sender
{
    [self.searchTerm resignFirstResponder];     // Keyboard vanishes.
    
    // Creating an SLRequest.
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"] parameters:@{@"q" : self.searchTerm.text}];    
   
    PSAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    request.account = appDelegate.viewController.twitterAccount;    // providing the SLRequest with the accessed twitter account. 
    
    // Sending the request.
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (responseData)
        {
            if (urlResponse.statusCode == 200)   // status - OK
            {                
                NSError *jsonError;
                NSDictionary *timelineData =  [NSJSONSerialization JSONObjectWithData:responseData  options:NSJSONReadingAllowFragments error:&jsonError];               
                
//                NSLog(@"%@", timelineData);            
                
                if (timelineData)
                {
                    PSSearchListDataParser *temptweetsData = [[PSSearchListDataParser alloc] init];
                    tweetsData = [temptweetsData parseData:timelineData];
                    
//                    NSLog(@"Tweets: %@", tweetsData);
                    
                    // If search query ends in 0 result.
                    if (!tweetsData)
                    {
                        UIAlertView *popUp = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Search results found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                        [popUp show];
                        });
                    }
                    else 
                        [self.tweets reloadData];                 

                }
                else
                {
                    // Our JSON deserialization went awry
                    NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                }
            }
            else
            {
                // The server did not respond successfully... were we rate-limited?
                NSLog(@"The response status code is %d", urlResponse.statusCode);
            }
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweetsData.count;  // count the number of tweets 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *albumTable = @"twitterCell";
    PStwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:albumTable];
    
    if (!cell)    
    {
        NSArray *Objects = [[NSBundle mainBundle] loadNibNamed:@"twitterCell" owner:nil options:Nil];
        
        for (id currentObject in Objects)
        {
            if ([currentObject isKindOfClass:[PStwitterCell class]])
            {
                cell = currentObject;
            }
        }
        
    }
    
    // If tweets found for search query.
    if(tweetsData)
    {
        NSDictionary *tweetDict = tweetsData[indexPath.row];
    
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[tweetDict objectForKey:@"profile_image_url_https"]]]];
        cell.user.text = [NSString stringWithFormat:@"%@  @%@", [tweetDict objectForKey:@"name"], [tweetDict objectForKey:@"screen_name"]];
        cell.tweet.text = [tweetDict objectForKey:@"text"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



@end
