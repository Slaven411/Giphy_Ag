//
//  GiphyCommunicator.m
//  Giphy
//
//  Created by Roma Herman on 2/10/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import "GiphyCommunicator.h"
#import "GiphyCommunicatorDelegate.h"

#define API_KEY @"dc6zaTOxFJmzC"
#define PAGE_COUNT 20

@implementation GiphyCommunicator

-(void)searchCategories:(NSString *)category withOffset:(NSInteger)currentOffset {
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://api.giphy.com/v1/gifs/search?q=%@&page%d&api_key=%@&count=25&offset=%li", category,PAGE_COUNT, API_KEY,(long)currentOffset];
    urlAsString = [urlAsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetcingCategoriesFailedWithError:error];
        } else {
            [self.delegate receivedCategoriesJSON:data];
        }
    }];
    
}
@end
