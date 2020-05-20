//
//  IntroViewController.swift
//  testIntroApp
//
//  Created by Kazuki Harada on 2020/05/20.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import Lottie

class IntroViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    //ファイル名
    var onboardArray = ["1","2","3","4","5"]
    
    //ファイルの説明文
    var onboardStringArray = ["この世界は","とっても","いい空気で","澄んでいる","気がする"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スクロールを可能にする
        scrollView.isPagingEnabled = true
        setUpScroll()
        
        //Lottie
        for count in 0...4{
            //アニメーションのインスタンス化
            let animationView = AnimationView()
            //アニメーションの作成
            //ページごとの名前で設定する
            let animation = Animation.named(onboardArray[count])
            //Int型count→CGFloat型にキャスティング、countの中身が増えた分だけ右に行く
            animationView.frame = CGRect(x: CGFloat(count) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            //アニメーション開始
            animationView.play()
            //scrollViewに配置
            scrollView.addSubview(animationView)
        }
    }
    
    //ナビゲーションバーを隠す
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //スクロールしてコンテンツを切り替える
    func setUpScroll(){
        scrollView.delegate = self
        //コンテンツサイズを決める
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: view.frame.size.height)
        
        //5回分のラベルをつける
        for count in 0...4{
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(count) * view.frame.size.width, y: view.frame.size.height / 3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[count]
            //scrollViewの上に、onboardLabelを表示する
            scrollView.addSubview(onboardLabel)
            
        }
        
    }
    
}
