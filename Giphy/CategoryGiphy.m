//
//  Category.m
//  Giphy
//
//  Created by Roma Herman on 2/11/16.
//  Copyright © 2016 SK. All rights reserved.
//

#import "CategoryGiphy.h"

@implementation CategoryGiphy : NSObject

- (NSString *)description {
    NSString *description = [NSString stringWithFormat:@"name = %@ '\n' url = %@ '\n' slug = %@ '\n' source = %@ '\n' rating = %@",self.name, self.url, self.slug, self.source, self.rating];
    return description;
}

@end
