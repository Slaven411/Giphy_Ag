//
//  CategoryBuilder.m
//  Giphy
//
//  Created by Roma Herman on 2/11/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import "CategoryBuilder.h"
#import "CategoryGiphy.h"

@implementation CategoryBuilder

+ (NSArray *)categoriesFromJSON:(NSData *)objectNotation error:(NSError *)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    
        if (localError != nil) {
        error = localError;
        return nil;
    }
    
    NSArray *allData = [parsedObject valueForKey:@"data"];
    
    for (NSDictionary *diction in allData) {
        CategoryGiphy *category = [[CategoryGiphy alloc] init];
        NSString *userName = [diction objectForKey:@"username"];
        NSString *source = [diction objectForKey:@"source"];
        NSString *rating = [diction objectForKey:@"rating"];
        NSString *slug = [diction objectForKey:@"slug"];

        NSDictionary *images = [diction objectForKey:@"images"];
        NSDictionary *fixed_width = [images objectForKey:@"fixed_width"];
        NSString *url = [fixed_width objectForKey:@"url"];
        
        category.name = userName;
        category.url = url;
        category.slug = slug;
        category.source = source;
        category.rating = rating;
        
        [categories addObject:category];
        
        NSLog(@"giphy = %@",source);
    }
    
    return categories;
}

@end

