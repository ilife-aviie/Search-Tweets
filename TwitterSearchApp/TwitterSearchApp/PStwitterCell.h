//
//  PStwitterCell.h
//  TwitterSearchApp
//
//  Created by DJ on 04/09/13.
//  Copyright (c) 2013 AvinashNehra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PStwitterCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *user;
@property (nonatomic, strong) IBOutlet UILabel *tweet;
@property (nonatomic, strong) IBOutlet UIImageView *profileImage;

@end
