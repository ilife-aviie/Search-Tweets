//timelinedata.json to be parsed(simplified) Sample
//{
//    "search_metadata" =     {
//    "completed_in" = "0.019";
//    count = 15;
//    "max_id" = 374839981765709824;
//    "max_id_str" = 374839981765709824;
//    .................................
//    };
//    statuses =     (
//                    1 {
//                        contributors = "<null>";
//                        coordinates = "<null>";
//                        "created_at" = "Tue Sep 03 10:23:10 +0000 2013";
//                        ................................................
//                    };               
//                        "favorite_count" = 0;
//                        favorited = 0;
//                        geo = "<null>";
//                        id = 374839981765709824;
//                        "id_str" = 374839981765709824;
//                    
//                        text = "Participate in life instead of just watching it pass you by.";
//                        truncated = 0;
//                        user =             {
//                            "contributors_enabled" = 0;
//                            "created_at" = "Sat Aug 24 01:34:26 +0000 2013";
//                            name = "Peter Parker";
//                            "profile_image_url_https" = "https://si0.twimg.com/profile_images/3788000......jpeg";                        
//                            "screen_name" = CaptJackSparrow;
//                            };
//                    },
//                
//                
//                    2 {
//                          //////////.........
//                    },
//                );
//}


#import "PSSearchListDataParser.h"

@interface PSSearchListDataParser ()
{
    NSMutableArray *returnArray;    // Array of dictionaries(With objects related 2 name, screen_name, profileImage Url, text/tweet)
    NSMutableDictionary *returnArrayDataItem;
}

@end

@implementation PSSearchListDataParser

-(NSArray *) parseData: (NSDictionary *) temptimelineData
{
    returnArray = [[NSMutableArray alloc] init];
    
    for (NSString *eachKey in temptimelineData)
    {
        id object = temptimelineData[eachKey];
        
        if ([eachKey isEqualToString:@"statuses"])
        {
            NSArray *tweetsData = object;
            if(tweetsData.count == 0)           // If search query ends in 0 result, the array will be empty. 
                return NULL;
            
                for (id eachObject in tweetsData) {
                    NSDictionary *tweet = eachObject;
                    returnArrayDataItem = [[NSMutableDictionary alloc] init];
                
                    for (NSString *eachKey in tweet) {
                        id object = tweet[eachKey];
                    
                        if ([eachKey isEqualToString:@"text"]) 
                            [returnArrayDataItem setObject:object forKey:@"text"];
                        
                        if ([eachKey isEqualToString:@"user"]) {
                                NSDictionary *userAttribute = object;
                            
                            for (NSString *eachKey in userAttribute) {
                                id object = userAttribute[eachKey];
                                
                                if ([eachKey isEqualToString:@"name"])
                                    [returnArrayDataItem setObject:object forKey:@"name"];
                                
                                if ([eachKey isEqualToString:@"screen_name"])
                                    [returnArrayDataItem setObject:object forKey:@"screen_name"];
                                
                                if ([eachKey isEqualToString:@"profile_image_url_https"])
                                    [returnArrayDataItem setObject:object forKey:@"profile_image_url_https"];                               
                            }                    
                        }
                    }                
                [returnArray addObject:returnArrayDataItem];
                    
                }
        }
    }
    
    return returnArray;
    
}

@end
