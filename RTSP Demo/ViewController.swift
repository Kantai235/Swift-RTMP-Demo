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
