//
//  Bucket.h
//  CoreDataDemo
//
//  Created by David Rogers on 2/12/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bucket : NSObject

@property (strong, nonatomic) Bucket *next;
@property (strong, nonatomic) id data;
@property (strong, nonatomic) NSString *key;

@end
