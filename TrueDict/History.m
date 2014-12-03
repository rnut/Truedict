//
//  History.m
//  TrueDict
//
//  Created by Rnut on 11/27/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import "History.h"

@implementation History

@synthesize ID_his,Voc;


-(id)initWithVocab:(Vocab *)voc{
    if ([self insertVocab:voc]) {
        return self;
    }
    return NO;
}


-(BOOL)clearHistoryWithLanguage:(DictLanguage)lang{
    DB *db = [[DB alloc] init];
    if ([db.ObjDb executeUpdate:[NSString stringWithFormat:@"delete from fav where language = %d",lang]]) {
        [db closeDB];
        return YES;
    }
    [db closeDB];
    return NO;
}
-(BOOL)deleteHistory{
    //    select id_fav from fav order by id_fav asc LIMIT 1
//    DB *db = [[DB alloc] init];
//    NSString *strQuery = @"select id_his from fav order by id_history asc LIMIT 1";
//    [db queryWithString:strQuery];
//    int deleteID = 0;
//    while ([db.ObjResult next]) {
//        deleteID = [db.ObjResult intForColumn:@"id_fav"];
//    }
//    NSString *strQueryDel = [NSString stringWithFormat:@"delete from history where id_fav = %d",deleteID];
//    if ([db.ObjDb executeUpdate:strQueryDel]) {
//        [db closeDB];
//        return YES;
//    }
//    [db closeDB];
    return NO;
}


#pragma mark HELPER METHOD
-(BOOL)insertVocab:(Vocab *)voc{
    DB *db = [[DB alloc] init];
    NSString *strQuery;
    
    if ([voc Language] == LanguageENG) {
        if ([self checkLimitHistoryWithLanguage:LanguageENG]) {
            strQuery = [NSString stringWithFormat:@"insert into fav (id_history,id,language) values (%d,%d,%d)",[self getLastID]+1,[voc IDvocab],[voc Language]];
            if([db.ObjDb executeUpdate:strQuery]){
                [db closeDB];
                
                [self setID_his:[self getLastID]+1];
                [self setVoc:voc];
                return YES;
            }
        }else{
            if ([self deleteHistory]) {
                strQuery = [NSString stringWithFormat:@"insert into fav (id_history,id,language) values (%d,%d,%d)",[self getLastID]+1,[voc IDvocab],[voc Language]];
                if([db.ObjDb executeUpdate:strQuery]){
                    [self setID_his:[self getLastID]+1];
                    [self setVoc:voc];
                    return YES;
                }
            }
        }
    }
    else if([voc Language] == LanguageTHA){
        if ([self checkLimitHistoryWithLanguage:LanguageTHA]) {
            strQuery = [NSString stringWithFormat:@"insert into fav (id_history,id,language) values (%d,%d,%d)",[self getLastID]+1,[voc IDvocab],[voc Language]];
            if([db.ObjDb executeUpdate:strQuery]){
                [db closeDB];
                [self setID_his:[self getLastID]+1];
                [self setVoc:voc];
                return YES;
            }
        }else{
            if ([self deleteHistory]) {
                strQuery = [NSString stringWithFormat:@"insert into fav (id_history,id,language) values (%d,%d,%d)",[self getLastID]+1,[voc IDvocab],[voc Language]];
                if([db.ObjDb executeUpdate:strQuery]){
                    [self setID_his:[self getLastID]+1];
                    [self setVoc:voc];
                    return YES;
                }
            }
        }
        
    }

    [db closeDB];
    return NO;

}
-(BOOL)checkLimitHistoryWithLanguage:(DictLanguage)lang{
    DB *db = [[DB alloc] init];
    if (lang == LanguageTHA) {
        if ([db checkNumRecordWithTable:@"history" Condition:[NSString stringWithFormat:@"language = %d",LanguageTHA]]<100) {
            [db closeDB];
            return YES;
        }
    }else if (lang == LanguageENG){
        if ([db checkNumRecordWithTable:@"history" Condition:[NSString stringWithFormat:@"language = %d",LanguageENG]]<100) {
            [db closeDB];
            return YES;
        }
    }
    [db closeDB];
    return NO;
}
-(int)getLastID{
    DB *db = [[DB alloc] init];
    int ret = [db getLastRecordIDWithTable:@"history" Column:@"id_his"];
    [db closeDB];
    return ret;
}

+(NSMutableArray *)listHistoryByLanguage:(DictLanguage)lang{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSString *strQuery;
    DB *db = [[DB alloc ]init];
    if (lang == LanguageENG) {
        strQuery = [NSString stringWithFormat:@"select IFNULL(b.id, '') as id, IFNULL(b.esearch, '') as search,IFNULL(b.tentry, '') as entry,IFNULL(b.ecat, '') as cat,IFNULL(b.esyn, '') as syn,IFNULL(b.eant, '') as ant from history a ,eng2th b where a.language = %d and a.id = b.id",lang];
        
        [db queryWithString:strQuery];
        while([db.ObjResult next]) {
            
            Vocab *tempv = [[Vocab alloc] initWithLanguage:lang IDvocab:[db.ObjResult intForColumn:@"id"] Search:[db.ObjResult stringForColumn:@"search"] Entry:[db.ObjResult stringForColumn:@"entry"] Cat:[db.ObjResult stringForColumn:@"cat"] Synonym:[db.ObjResult stringForColumn:@"syn"] Antonym:@"ant"];
            History *temp = [[History alloc] initWithVocab:tempv];
            [ret addObject:temp];
        }
        [db closeDB];
        
        
        
    }
    else if(lang == LanguageTHA){
        strQuery = [NSString stringWithFormat:@"select IFNULL(b.id, '') as id, IFNULL(b.tsearch, '') as search,IFNULL(b.eentry, '') as entry,IFNULL(b.tcat, '') as cat,IFNULL(b.tsyn, '') as syn,IFNULL(b.tant, '') as ant from history a ,th2eng b where a.language = %d and a.id = b.id",lang];
        [db queryWithString:strQuery];
        while([db.ObjResult next]) {
            Vocab *tempv = [[Vocab alloc] initWithLanguage:lang IDvocab:[db.ObjResult intForColumn:@"id"] Search:[db.ObjResult stringForColumn:@"search"] Entry:[db.ObjResult stringForColumn:@"entry"] Cat:[db.ObjResult stringForColumn:@"cat"] Synonym:[db.ObjResult stringForColumn:@"syn"] Antonym:@"ant"];
            History *temp = [[History alloc] initWithVocab:tempv];
            [ret addObject:temp];
        }
        [db closeDB];
    }
    
    
    
    return ret;
}


@end
