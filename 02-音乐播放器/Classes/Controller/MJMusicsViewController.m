//
//  MJMusicsViewController.m
//  02-音乐播放器
//
//  Created by apple on 14-6-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJMusicsViewController.h"
#import "MJMusic.h"
#import "MJMusicCell.h"
#import "MJExtension.h"
#import "MJAudioTool.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface MJMusicsViewController () <AVAudioPlayerDelegate>
- (IBAction)jump:(id)sender;
@property (strong, nonatomic) NSArray *musics;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) AVAudioPlayer *currentPlayingAudioPlayer;
@property(nonatomic,strong)NSIndexPath  * selectIndePath;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property(nonatomic,strong)NSArray * songerArr;
@property (strong, nonatomic) UISlider *slider;
@property(nonatomic,assign)NSInteger isdrect;
- (IBAction)playBtn:(id)sender;
@end

@implementation MJMusicsViewController


- (NSArray *)musics
{
    if (!_musics) {
        self.musics = [MJMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

- (CADisplayLink *)link
{
    if (!_link) {
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
//    NSData *mydata=[[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://sc.111ttt.com/up/mp3/241018/FBF00FBC9AF03CAC7C03BD71FC62FD5B.mp3"]];
//    NSLog(@"-----%@",mydata);
//    AVAudioPlayer *player=[[AVAudioPlayer alloc]initWithData:mydata error:nil];
//    
//    [player prepareToPlay];
//    
//    [player play];
//    self.currentPlayingAudioPlayer=player;

//    NSURL * url  = [NSURL URLWithString:@"http://sc.111ttt.com/up/mp3/241018/FBF00FBC9AF03CAC7C03BD71FC62FD5B.mp3"];
//    AVPlayerItem * songItem = [[AVPlayerItem alloc]initWithURL:url];
//    AVPlayer * player = [[AVPlayer alloc]initWithPlayerItem:songItem];
////        AVPlayer * player = [[AVPlayer alloc] initWithURL:url];
// 
//    [player play];
    
//    self.players=player;
    

    
//    NSError *sessionError = nil;
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
//    [[AVAudioSession sharedInstance] setActive:YES error:nil];
//    
//    NSString * url= @"http://sc.111ttt.com/up/mp3/241018/FBF00FBC9AF03CAC7C03BD71FC62FD5B.mp3";
//
//    NSURL * songUrl = [NSURL URLWithString:url];
//    
//    AVURLAsset *movieAsset = [[AVURLAsset alloc]initWithURL:songUrl options:nil];
//    
//    self.playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//    
//    [self.playerItem addObserver:self forKeyPath:@"status" options:0 context:NULL];
//
//    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
//    
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    
//    playerLayer.frame = self.view.layer.bounds;
//    
//    
//    [self.view.layer addSublayer:playerLayer];
//    [self.player setAllowsExternalPlayback:YES];
//    [self.player play];





    
    
    

    
    
    self.slider=[[UISlider alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height-110, self.view.frame.size.width-60, 30)];
    self.slider.minimumValue=0;
    self.slider.maximumValue=1;
    self.slider.minimumValueImage=[UIImage imageNamed:@"eason_icon"];
    self.slider.maximumValueImage=[UIImage imageNamed:@"jj_icon"];
    [self.slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    self.slider.continuous=YES;
    
    [self.view addSubview:self.slider];
 
    self.isdrect=-10;
   self.songerArr=[[NSArray alloc]initWithObjects:@"我的爱豆方式上的恐惧",@"上帝视角山东快书空间",@"完美的心腹的反馈"@"时时刻刻说的秘密呢",@"山东省开始对方考虑到付款",@"爱与不爱都是输",@"时间的黄金时代回家说的话就是",@"是颠三倒四看到快手快脚离开是马丁内斯牛奶",@"山东省看到快乐山东快书快乐；；；；"@"时速度加快  项目，信息查询",@"求哦 i 我期望 ii 哦请问 i去外婆去",@"爱却求 iiu",nil];
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//
//{
//    NSLog(@"%@",keyPath);
//    if ([keyPath isEqualToString:@"status"])
//        
//    {
//        NSLog(@"%zd",self.player.currentItem.status);
//        if (AVPlayerItemStatusReadyToPlay == self.player.currentItem.status)
//            
//        {
//            
//            [self.player play];
//            
//        }
//        
//        if (self.player.currentItem.status==AVPlayerItemStatusFailed) {
//            NSLog(@"播放失败");
//        }
//        
//        
//        
//        
//    }
//    
//    
//    if ([keyPath isEqualToString:@"currentTime"]) {
//       
//        NSLog(@"%@",change);
////        self.slider.value;
//        
//    }
//    
//}



- (void)changeValue:(UISlider*)slider
{
  
    
    NSLog(@"--%f",self.currentPlayingAudioPlayer.currentTime/self.currentPlayingAudioPlayer.duration);
    
//        [self.link invalidate];
//        self.link=nil;
        self.currentPlayingAudioPlayer.currentTime=slider.value*self.currentPlayingAudioPlayer.duration;
        //    [NSThread sleepForTimeInterval:3];
//        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

    
    }

/**
 *  Remote控制
 
     在播放视图的ViewController里加上这两个函数:
 */

//-(void)viewWillAppear:(BOOL)animated
//{
//
//
//    [super viewWillAppear:animated];
//    [[ UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    [self becomeFirstResponder];
//}
//
//- (void) viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
//    [self resignFirstResponder];
//}
//- (BOOL)canBecomeFirstResponder
//{
//    return YES;
//}

/**
 *  实时更新(1秒中调用60次)
 */

- (void)update
{
//    NSLog(@"%f %f", self.currentPlayingAudioPlayer.duration, self.currentPlayingAudioPlayer.currentTime);
    float curreTime=self.currentPlayingAudioPlayer.currentTime;
    float totalTime=self.currentPlayingAudioPlayer.duration;
    NSInteger index =0;
        if (0<curreTime && curreTime<totalTime*0.1) {
            index=0;
           
        }
    if (totalTime*0.1<curreTime &&curreTime<totalTime*0.2) {
        index=1;
        
    }
    if (totalTime*0.2<curreTime&&curreTime<totalTime*0.3) {
        index=2;
        
    }
    if (totalTime*0.3<curreTime&&curreTime<totalTime*0.4) {
        index=3;
        
    }
    if (totalTime*0.4<curreTime&&curreTime<totalTime*0.5) {
        index=4;
      
    }
    if (0.5*totalTime<curreTime && curreTime<totalTime*0.6) {
        index=5;
        
    }
    if (totalTime*0.6<curreTime &&curreTime<totalTime*0.7) {
        index=6;
        
    }
    if (totalTime*0.7<curreTime&&curreTime<totalTime*0.8) {
        index=7;
        
    }
    if (totalTime*0.8<curreTime&&curreTime<totalTime*0.9) {
        index=8;
        
    }
    if (totalTime*0.9<curreTime&&curreTime<totalTime*1) {
        index=9;
        
    }
    
    NSLog(@"--%f",self.currentPlayingAudioPlayer.currentTime/self.currentPlayingAudioPlayer.duration);
    self.slider.value=self.currentPlayingAudioPlayer.currentTime/self.currentPlayingAudioPlayer.duration;

////    防止每时每刻都drect
//    if (index!=self.isdrect) {
#warning 调整歌词
        MJMusic * music=self.musics[self.selectIndePath.row];
        [self showInfoInLockedScreen:music WithIndex:index];
//    }
//  
//    self.isdrect=index;
}

- (UIImage *)addImage:(UIImage *)image1 toIndex:( NSInteger )index
{
    
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
//    [image2 drawInRect:CGRectMake(0, image1.size.height-50, image2.size.width, image2.size.height)];
    
    NSString * textString1;
    NSString * textString2;
    NSString * textString3;
    CGFloat x;
    if (index==0) {
        textString1=self.songerArr[0];
         x=(image1.size.width-textString1.length*20)/2;
        [textString1 drawInRect:CGRectMake(x, image1.size.height-120, textString1.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSBackgroundColorAttributeName:[UIColor yellowColor]}];
        textString2=self.songerArr[1];
        x=(image1.size.width-textString2.length*20)/2;
        [textString2 drawInRect:CGRectMake(x, image1.size.height-80, textString2.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
        
        textString3=self.songerArr[2];
        x=(image1.size.width-textString3.length*20)/2;
        [textString3 drawInRect:CGRectMake(x, image1.size.height-40,textString3.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
        
    }else if (index>0&&index<self.songerArr.count-1){
         textString1=self.songerArr[index-1];
        
        x=(image1.size.width-textString1.length*20)/2;
        [textString1 drawInRect:CGRectMake(x, image1.size.height-120, textString1.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
        
         textString2=self.songerArr[index];
        x=(image1.size.width-textString2.length*20)/2;
        [textString2 drawInRect:CGRectMake(x, image1.size.height-80, textString2.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSBackgroundColorAttributeName:[UIColor yellowColor]}];
         textString3=self.songerArr[index+1];
        
        x=(image1.size.width-textString3.length*20)/2;
        [textString3 drawInRect:CGRectMake(x, image1.size.height-40, textString3.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    }else if (index==self.songerArr.count-1)
    {
    
        textString1=self.songerArr[index-2];
        x=(image1.size.width-textString1.length*20)/2;
        [textString1 drawInRect:CGRectMake(x, image1.size.height-120, textString1.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];

        textString2=self.songerArr[index-1];
        
        x=(image1.size.width-textString2.length*20)/2;
        [textString2 drawInRect:CGRectMake(x, image1.size.height-80, textString2.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
        textString3=self.songerArr[index];
        
        x=(image1.size.width-textString3.length*20)/2;
        [textString3 drawInRect:CGRectMake(x, image1.size.height-40, textString3.length*20, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSBackgroundColorAttributeName:[UIColor yellowColor]}];

    
    }
    
    
//    CGFloat x=(image1.size.width-textString1.length*17)/2;
//    [textString1 drawInRect:CGRectMake(x, image1.size.height-40, image1.size.width, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSBackgroundColorAttributeName:[UIColor yellowColor]}];
//    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musics.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    MJMusicCell *cell = [MJMusicCell cellWithTableView:tableView];
    
    // 2.设置cell的数据
    cell.music = self.musics[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 停止音乐
    MJMusic *music = self.musics[indexPath.row];
    [MJAudioTool stopMusic:music.filename];
    
    // 再次传递模型
    MJMusicCell *cell = (MJMusicCell *)[tableView cellForRowAtIndexPath:indexPath];
    music.playing = NO;
    cell.music = music;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    // 如果连续点击同一个cell  就不再次传递模型
//    
//    if ((self.selectIndePath.section==indexPath.section)&&(self.selectIndePath.row==indexPath.row)) return;
    self.selectIndePath=indexPath;
    // 播放音乐
    MJMusic *music = self.musics[indexPath.row];
    AVAudioPlayer *audioPlayer = [MJAudioTool playMusic:music.filename];
    audioPlayer.delegate = self;
    self.currentPlayingAudioPlayer = audioPlayer;
    
    // 在锁屏界面显示歌曲信息
//    [self showInfoInLockedScreen:music];
    
    
    // 开启定时器监听播放进度
    [self.link invalidate];
    self.link = nil;
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//
  
    // 再次传递模型
    MJMusicCell *cell = (MJMusicCell *)[tableView cellForRowAtIndexPath:indexPath];
    music.playing = YES;
    cell.music = music;

//    重置slider 的值
    self.slider.value=0.0;
    
}

/**
 *  在锁屏界面显示歌曲信息
 */
- (void)showInfoInLockedScreen:(MJMusic *)music WithIndex:(NSInteger)index
{
    
  UIImage * image=  [self addImage:[UIImage imageNamed:music.icon] toIndex:index];
    
    
    
    
    
    
    

    // 健壮性写法:如果存在这个类,才能在锁屏时,显示歌词
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        // 核心:字典
        NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
        // 标题(音乐名称)
        [info setValue:music.name forKey:MPMediaItemPropertyTitle];
        // 艺术家
        [info setValue:music.singer forKey:MPMediaItemPropertyArtist];
        // 专辑名称
        [info setValue:music.singer forKey:MPMediaItemPropertyAlbumTitle];
        // 图片
        [info setValue:[[MPMediaItemArtwork alloc] initWithImage:image] forKey:MPMediaItemPropertyArtwork];
        // 唯一的API,单例,nowPlayingInfo字典
        
        [info setObject:[NSNumber numberWithDouble:self.currentPlayingAudioPlayer.currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
        [info setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        [info setObject:[NSNumber numberWithDouble:self.currentPlayingAudioPlayer.duration] forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
        
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:info];
        
    }
    
    

}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    // 计算下一行
    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    int nextRow = selectedPath.row + 1;
    if (nextRow == self.musics.count) {
        nextRow = 0;
    }
    
#warning 停止上一首歌的转圈
    // 再次传递模型
    MJMusicCell *cell = (MJMusicCell *)[self.tableView cellForRowAtIndexPath:selectedPath];
    MJMusic *music = self.musics[selectedPath.row];
    music.playing = NO;
    cell.music = music;
    
    //播放下一首歌
    NSIndexPath *currentPath = [NSIndexPath indexPathForRow:nextRow inSection:selectedPath.section];
    [self.tableView selectRowAtIndexPath:currentPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self tableView:self.tableView didSelectRowAtIndexPath:currentPath];
}

/**
 *  音乐播放器被打断(打\接电话)
 */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    NSLog(@"audioPlayerBeginInterruption---被打断");
}

/**
 *  音乐播放器停止打断(打\接电话)
 */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    NSLog(@"audioPlayerEndInterruption---停止打断");
    [player play];
}




#pragma mark  截取锁屏界面的点击事件

//之后就可以在该controller里接收
- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
            {
                NSLog(@"UIEventSubtypeRemoteControlTogglePlayPause");

            
            }
            case UIEventSubtypeRemoteControlPlay:
            {
                
                NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
                
                [self tableView:self.tableView didDeselectRowAtIndexPath:selectedPath];
                [self tableView:self.tableView didSelectRowAtIndexPath:selectedPath];
            
                break;
            }
                
            case UIEventSubtypeRemoteControlPause:
            {
                
                NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
                
                NSLog(@"--------%zd  %zd",selectedPath.section,selectedPath.row);

                
                [self tableView:self.tableView didDeselectRowAtIndexPath:selectedPath];
                [self.currentPlayingAudioPlayer pause];
                
                NSLog(@"%zd  %zd",self.selectIndePath.section,self.selectIndePath.row);
                
                
                
                
                [self.link invalidate];
                self.link = nil;
            }
                 break;
            case UIEventSubtypeRemoteControlStop:
            {

                NSLog(@"UIEventSubtypeRemoteControlPause");


            }
                break;
  
            case UIEventSubtypeRemoteControlNextTrack:
            {
                NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];

                [self tableView:self.tableView didDeselectRowAtIndexPath:selectedPath];
                [self audioPlayerDidFinishPlaying:self.currentPlayingAudioPlayer successfully:YES];
                
               
            }
               break;
            case UIEventSubtypeRemoteControlPreviousTrack:
            {
              
                [self playPreRowMuisc];

               
            }
                 break;
            default:
                break;
        }
    }
}

- (void)playPreRowMuisc
{

    
    
    // 计算下上行
    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
        
    [self tableView:self.tableView didDeselectRowAtIndexPath:selectedPath];
    NSInteger PreRow=selectedPath.row ;

    if (PreRow == 0) {
        PreRow = self.musics.count-1;
    }else{
       PreRow = selectedPath.row -1;
    }
    
    
#warning 停止上一首歌的转圈
    // 再次传递模型
    MJMusicCell *cell = (MJMusicCell *)[self.tableView cellForRowAtIndexPath:selectedPath];
    MJMusic *music = self.musics[selectedPath.row];
    music.playing = NO;
    cell.music = music;
    
    // 播放下一首歌
    
    
    NSLog(@"--------%zd  %zd",selectedPath.section,selectedPath.row);
    
    NSLog(@"=====%zd  %zd",self.selectIndePath.section,self.selectIndePath.row);
    NSIndexPath *currentPath = [NSIndexPath indexPathForRow:PreRow inSection:selectedPath.section];
    
    NSLog(@"+++++++++++%zd  %zd",PreRow,selectedPath.section);

    [self.tableView selectRowAtIndexPath:currentPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self tableView:self.tableView didSelectRowAtIndexPath:currentPath];


}

- (IBAction)jump:(id)sender {
   
    
//    self.currentPlayingAudioPlayer.currentTime = self.currentPlayingAudioPlayer.duration - 3;
    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    
    NSLog(@"--------%zd  %zd",selectedPath.section,selectedPath.row);
    
    
    [self tableView:self.tableView didDeselectRowAtIndexPath:selectedPath];
    [self.currentPlayingAudioPlayer pause];
    
    NSLog(@"%zd  %zd",self.selectIndePath.section,self.selectIndePath.row);
    
    
    
    
    [self.link invalidate];
    self.link = nil;

    
}



- (IBAction)playBtn:(id)sender {
    
    
    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
    
    [self tableView:self.tableView didDeselectRowAtIndexPath:selectedPath];
    [self tableView:self.tableView didSelectRowAtIndexPath:selectedPath];

    
}



@end