//
//  History.h
//  TrueDict
//
//  Created by Rnut on 11/27/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vocab.h"
#import "DB.h"
@interface History : NSObject

-(int)checkRecordHistory;
-(BOOL)keepHistory:(Vocab *)voc;
-(BOOL)clearHistory;
-(void)showHistory;
@end
