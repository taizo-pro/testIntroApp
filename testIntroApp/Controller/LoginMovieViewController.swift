//
//  LoginMovieViewController.swift
//  testIntroApp
//
//  Created by Kazuki Harada on 2020/05/21.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import AVFoundation

class LoginMovieViewController: UIViewController {

    var player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "start", ofType: "mov")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //AVPlayer用のレイヤーを作成する
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        playerLayer.videoGravity = .resizeAspectFill
        //無限に回す
        playerLayer.repeatCount = 0
        //ログインボタンを上に持ってくるため
        playerLayer.zPosition = -1
        //viewのlayerに、playerLayerを挿入する
        view.layer.insertSublayer(playerLayer, at: 0)
        
        //最初から再生させる
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
            self.player.seek(to: .zero)
            self.player.play()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func login(_ sender: Any) {
        player.pause()
    }
    
    
}
