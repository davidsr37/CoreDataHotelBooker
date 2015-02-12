//
//  HashTable.h
//  CoreDataDemo
//
//  Created by David Rogers on 2/12/15.
//  Copyright (c) 2015 David Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

-(void)setObject:(id) object forKey:(NSString*)key;

-(void)removeObjectForKey:(NSString *)key;

-(id)objectForKey:(NSString*)key;

-(instancetype)initWithSize:(NSInteger)size;


@end
