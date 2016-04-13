//
//  CategoryBuilder.h
//  Giphy
//
//  Created by Roma Herman on 2/11/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryBuilder : NSObject

+ (NSArray *)categoriesFromJSON:(NSData *)objectNotation error:(NSError *)error;

@end
