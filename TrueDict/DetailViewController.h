//
//  DetailViewController.h
//  TrueDict
//
//  Created by Rnut on 11/27/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Vocab.h"
#import "Favorite.h"
#import "History.h"
@interface DetailViewController : UIViewController


@property(nonatomic,strong)AVAudioPlayer *Player;

-(IBAction)speakSpeech:(id)sender;
-(IBAction)changeVocab:(id)sender;
@end
