//
//  History.m
//  TrueDict
//
//  Created by Rnut on 11/27/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import "History.h"

@implementation History



-(int)checkRecordHistory;{
    int idrec = 0;
    DB *db = [[DB alloc] init];
    [db queryWithString:@"select count(*)as count from eng2th"];
    while([db.ObjResult next]) {
            idrec =  [db.ObjResult intForColumn:@"count"];
    }
    [db closeDB];
    return idrec;
}
-(BOOL)keepHistory:(Vocab *)voc{
    DB *db = [[DB alloc] init];
    int numrec = [self checkRecordHistory];
    int idrec;
    NSString *strQuery;
    if (numrec <= 20) {
            idrec = numrec+1;
            strQuery = [NSString stringWithFormat:@"insert into history (id_history ,id) values (%d,%@,%@,%@,%@,%@,%@,%@,%@,%@)",idrec,[voc esearch],[voc tentry],[voc eentry],[voc ecat],[voc esyn],@"",[voc eant],@"",[voc ethai]];
    }else{
        idrec = numrec-20;
        NSString * strDelQuery = [NSString stringWithFormat:@"delete from fav where id = %d",idrec];
        [db queryWithString:strDelQuery];
        //check if query success
        idrec = numrec+1;
        strQuery = [NSString stringWithFormat:@"insert into fav (id ,search,tentry,eentry,cat,syn,sample,ant,def,translate) values (%d,%@,%@,%@,%@,%@,%@,%@,%@,%@)",idrec,[voc esearch],[voc tentry],[voc eentry],[voc ecat],[voc esyn],@"",[voc eant],@"",[voc ethai]];
    }
    [db queryWithString:strQuery];
    [db closeDB];
    //check query success
//        return YES
    
    return NO;
}
-(BOOL)clearHistory{

    return NO;
}
-(void)showHistory{
    DB *db = [[DB alloc] init];
    NSString *strQuery = @"select count(*) as count from history";
    [db queryWithString:strQuery];
    while ([db.ObjResult next]) {
        NSLog(@"%@",[db.ObjResult stringForColumn:@"count"]);
    }
    [db closeDB];
    
    
}
-(void)showFavorite{
    DB *db = [[DB alloc] init];
    NSString *strQuery = @"select count(*) as count from fav";
    [db queryWithString:strQuery];
    while ([db.ObjResult next]) {
        NSLog(@"%@",[db.ObjResult stringForColumn:@"count"]);
    }
    [db closeDB];
}













@end
