# RTMP for Swift Demo

這是一件參考 [http://www.hangge.com/blog/cache/detail_1326.html] 所寫的一份教學，採用的是 IJKMediaFramework 來完成讀取 RTMP 串流直播。

### 簡報說明

等待補充

### 環境部署(來自 hangge.com 的教學)

```sh
# (1) 安装homebrew, git, yasm
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git
brew install yasm

# (2) 下載 IJKplayer
git clone https://github.com/Bilibili/ijkplayer.git ijkplayer-ios

# (3) 將 ffmpeg 集成到 IJKplayer 中
cd ijkplayer-ios
git checkout -B latest k0.6.0
./init-ios.sh
cd ios
./compile-ffmpeg.sh clean
./compile-ffmpeg.sh all
```

... 接下來的步驟太長了，所以「略」！有興趣請看：<br />
[http://www.hangge.com/blog/cache/detail_1326.html]<br />
[http://www.hangge.com/blog/cache/detail_1327.html]<br />
[https://github.com/afr0man17/RTSP-Client]<br />
[http://blog.diveinedu.com/swift_fifa_mac_ios/]<br />

### 引入 Framework

在本 Demo 當中，擁有 IJKMediaFramework.framework 檔案，可以自行下載到專案當中，接着添加一些依賴的動態庫。

```
AudioToolbox.framework
AVFoundation.framework
CoreGraphics.framework
CoreMedia.framework
CoreVideo.framework
libbz2.tbd
libz.tbd
MediaPlayer.framework
MobileCoreServices.framework
OpenGLES.framework
QuartzCore.framework
UIKit.framework
VideoToolbox.framework
```

### 範例

首先你必須參考 IJKMediaFramework

```Swift
import IJKMediaFramework
```

完整範例

```Swift
//
//  ViewController.swift
//  RTSP Demo
//
//  Created by 乾太 on 2016/11/4.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit
import IJKMediaFramework

class ViewController: UIViewController {

    var player : IJKFFMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = IJKFFOptions.byDefault()
        
        let url = NSURL(string: "rtmp://live.hkstv.hk.lxdns.com/live/hks")
        
        // 初始化播放器，播放線上影片或直播（RTMP）
        let player = IJKFFMoviePlayerController(contentURL: url as URL!, with: options)
        
        // 播放頁面寬高自適應
        let autoresize = UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue
        player?.view.autoresizingMask = UIViewAutoresizing(rawValue: autoresize)
        player?.view.frame = self.view.bounds
        
        // 縮放模式
        player?.scalingMode = .aspectFit
        // 啟動後自動播放
        player?.shouldAutoplay = true
        
        self.view.autoresizesSubviews = true
        self.view.addSubview((player?.view)!)
        self.player = player
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 開始播放
        self.player.prepareToPlay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 關閉播放器
        self.player.shutdown()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
```