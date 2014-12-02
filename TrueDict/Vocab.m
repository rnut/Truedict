//
//  Vocab.m
//  DemoSqlite
//
//  Created by Rnut on 11/25/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import "Vocab.h"

@implementation Vocab

@synthesize Language,IDvocab,Search,Cat,Antonym,SoundPath,ImgPath;


- (int)getDictLanguage:(DictLanguage)lang
{
    switch (lang) {
        case LanguageENG: return 1;
        case LanguageTHA: return 0;
        default: return 0;
    }
}


-(id)initWithLanguage:(DictLanguage)lang IDvocab:(int)idvocab Search :(NSString *)strsearch Entry:(NSString *)strentry Cat:(NSString*)strcat Synonym:(NSString*)strsyn Antonym:(NSString*)strant{
    
    [self setLanguage:lang];
    [self setIDvocab:idvocab];
    [self setSearch:strsearch];
    [self setEntry:strentry];
    [self setCat:strcat];
    [self setSynonym:strsyn];
    [self setAntonym:strant];
    return self;
    
}
+(NSMutableArray *)listDictByVocab:(NSString *)vocab{
    DB *db = [[DB alloc ]init];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    DictLanguage lang;
    lang = [Vocab checkLanguage:vocab];
    if (lang == LanguageTHA) {
        
    }
    else if(lang == LanguageENG){
        [db queryWithString:[NSString stringWithFormat:@"select IFNULL(id, '') as id, IFNULL(esearch, '') as esearch,IFNULL(eentry, '') as eentry,IFNULL(tentry, '') as tentry,IFNULL(ecat, '') as ecat,IFNULL(ethai, '') as ethai,IFNULL(esyn, '') as esyn,IFNULL(eant, '') as eant from eng2th where esearch LIKE '%@%%'",vocab]];
        
        while([db.ObjResult next]) {
            Vocab *temp = [[Vocab alloc] initWithLanguage:lang IDvocab:[db.ObjResult intForColumn:@"id"] Search:[db.ObjResult stringForColumn:@"esearch"] Entry:[db.ObjResult stringForColumn:@"tentry"] Cat:[db.ObjResult stringForColumn:@"ecat"] Synonym:[db.ObjResult stringForColumn:@"esyn"] Antonym:@"eatn"];
            [ret addObject:temp];
        }
    }
    [db closeDB];
    return ret;
}

#pragma mark load data from api server
-(BOOL)loadSound{
//    todo  Asyn get data
    NSString *path = [APSpeech getSpeechThis:[self Search] inLanguage:APSpeechLanguageENG];
    if (![path isEqualToString:@"failed"]) {
        [self setSoundPath:path];
        return YES;
    }
    return NO;
}
+(DictLanguage)checkLanguage:(NSString*)search{
    DictLanguage lang;
    int ascii = [search characterAtIndex:0];
    if (ascii > 3584 && ascii < 3631) {
        lang = LanguageTHA;
    }
    else if ((ascii > 64 && ascii < 91 ) || (ascii >96 && ascii < 123)){
        lang = LanguageENG;
    }
    return lang;
}


//-(BOOL)loadImageWithAPIPath:(NSString *)path{
//    return NO;
//}
//#pragma mark favorite
//-(BOOL)favoriteThis{
//    
//    
//    return NO;
//}
@end
