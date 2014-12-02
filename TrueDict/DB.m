//
//  DB.m
//  DemoSqlite
//
//  Created by Rnut on 11/25/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import "DB.h"

@implementation DB

@synthesize ObjDb,ObjResult;
-(id)init{
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *dbPath = [docsPath stringByAppendingPathComponent:@"lexitron.sqlite"];
    ObjDb = [FMDatabase databaseWithPath:dbPath];
    [self openDB];
    return self;
}
-(void)closeDB{
    [ObjDb close];
}
-(void)openDB{
    [ObjDb open];
}
-(void)queryWithString:(NSString*)query{
        ObjResult = [ObjDb executeQuery:query];
}

@end
