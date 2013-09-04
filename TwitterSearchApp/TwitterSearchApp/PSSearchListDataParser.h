//
//  PSSearchListDataParser.h
//  TwitterSearchApp
//
//  Created by DJ on 04/09/13.
//  Copyright (c) 2013 AvinashNehra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSSearchListDataParser : NSObject

-(NSArray *) parseData: (NSDictionary *) temptimelineData;

@end
