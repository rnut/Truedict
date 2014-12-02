//
//  DetailViewController.m
//  TrueDict
//
//  Created by Rnut on 11/27/2557 BE.
//  Copyright (c) 2557 Rnut. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    Vocab *a;
}
@end

@implementation DetailViewController
@synthesize Player;
- (void)viewDidLoad {
    [super viewDidLoad];
    //a = [[Vocab alloc] initWithEsearch:@"sanook" Eentry:@"" Tentry:@"" Ecat:@"" Ethai:@"" Esyn:@"" Eant:@""];
    //[a loadSound];
//    NSMutableArray *arr = [Vocab listDictByVocab:@"test" Lang:LanguageENG];
    NSMutableArray *arr = [Favorite listFavorite:LanguageTHA];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)speakSpeech:(id)sender{
//    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
//    [audioSession setActive:YES error:nil];
//    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",[a esearch]]];
//    NSLog(@"%@",path);
//    NSError *err;
//    if ( [[NSFileManager defaultManager] fileExistsAtPath:path] )
//    {
//        if ( Player && [Player isPlaying] ) {
//            [Player stop];
//            Player = nil;
//        }
//        
//        Player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&err];
//        Player.volume =2.0f;
//        [Player prepareToPlay];
//        [Player setNumberOfLoops:0];
//        [Player play];
//    }
    
}
-(IBAction)changeVocab:(id)sender{
//    [a setEsearch:@"according"];
//    [a loadSound];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
