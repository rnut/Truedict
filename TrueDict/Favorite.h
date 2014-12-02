//
//  Favorite.h
//  TrueDict
//
//  Created by Rnut on 12/1/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import "Vocab.h"

@interface Favorite : Vocab

@property(nonatomic,assign)int ID_fav;
@property(nonatomic,strong)Vocab *Fav_vocab;

-(BOOL)keepFavorite:(Vocab*)fav_vocab;
+(NSMutableArray *)listFavorite:(DictLanguage)lang;

@end
