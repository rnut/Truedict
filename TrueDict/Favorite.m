//
//  Favorite.m
//  TrueDict
//
//  Created by Rnut on 12/1/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import "Favorite.h"
#import "Vocab.h"
@implementation Favorite

@synthesize IDvocab,Fav_vocab;


-(BOOL)keepFavorite:(Vocab*)fav_vocab{
    DB *db = [[DB alloc] init];
    int idrec = 0;
    NSString *strQuery;
    idrec = [self getIDLastRecord];
    strQuery = [NSString stringWithFormat:@"insert into fav (id_fav ,id,language) values (%d,%d,%d)",idrec,[fav_vocab IDvocab],[fav_vocab Language]];
    [db queryWithString:strQuery];
    [db closeDB];
    //check query success
    //        return YES
    
    return NO;
}
+(NSMutableArray *)listFavorite:(DictLanguage)lang{
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSString *strQuery;
    DB *db = [[DB alloc ]init];
    if (lang == LanguageENG) {
        strQuery = [NSString stringWithFormat:@"select IFNULL(b.id, '') as id, IFNULL(b.esearch, '') as search,IFNULL(b.tentry, '') as entry,IFNULL(b.ecat, '') as cat,IFNULL(b.esyn, '') as syn,IFNULL(b.eant, '') as ant from fav a ,eng2th b where a.language = %d and a.id = b.id",lang];
        
        [db queryWithString:strQuery];
        while([db.ObjResult next]) {
            Vocab *temp = [[Vocab alloc] initWithLanguage:lang IDvocab:[db.ObjResult intForColumn:@"id"] Search:[db.ObjResult stringForColumn:@"search"] Entry:[db.ObjResult stringForColumn:@"entry"] Cat:[db.ObjResult stringForColumn:@"cat"] Synonym:[db.ObjResult stringForColumn:@"syn"] Antonym:@"ant"];
            [ret addObject:temp];
        }
        [db closeDB];
        
        
        
    }
    else if(lang == LanguageTHA){
        strQuery = [NSString stringWithFormat:@"select IFNULL(b.id, '') as id, IFNULL(b.tsearch, '') as search,IFNULL(b.eentry, '') as entry,IFNULL(b.tcat, '') as cat,IFNULL(b.tsyn, '') as syn,IFNULL(b.tant, '') as ant from fav a ,th2eng b where a.language = %d and a.id = b.id",lang];
        [db queryWithString:strQuery];
        while([db.ObjResult next]) {
            Vocab *temp = [[Vocab alloc] initWithLanguage:lang IDvocab:[db.ObjResult intForColumn:@"id"] Search:[db.ObjResult stringForColumn:@"search"] Entry:[db.ObjResult stringForColumn:@"entry"] Cat:[db.ObjResult stringForColumn:@"cat"] Synonym:[db.ObjResult stringForColumn:@"syn"] Antonym:@"ant"];
            [ret addObject:temp];
        }
        [db closeDB];
    }
    
  
    
    return ret;
}

-(int)getIDLastRecord{
//    select id_fav from fav ORDER by id_fav desc LIMIT 1
    int idrec = 0;
    DB *db = [[DB alloc] init];
    [db queryWithString:@"select id_fav from fav ORDER by id_fav desc LIMIT 1"];
    while([db.ObjResult next]) {
        idrec =  [db.ObjResult intForColumn:@"id_fav"];
    }
    [db closeDB];
    return idrec;

    
}

@end
