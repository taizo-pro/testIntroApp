//
//  BaseViewController.swift
//  testIntroApp
//
//  Created by Kazuki Harada on 2020/05/21.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import SegementSlide

class BaseViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
        defaultSelectedIndex = 0
    }
    
    override func segementSlideHeaderView() -> UIView? {
        //headerに画像をつける
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "header")
        //オプション
        headerView.translatesAutoresizingMaskIntoConstraints = false
        //headerの高さ
        let headerHeight:CGFloat
        if #available(iOS 11.0, *){
            headerHeight = view.bounds.height / 4 + view.safeAreaInsets.top
        }else{
            headerHeight = view.bounds.height / 4 + topLayoutGuide.length
        }
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
        return headerView
    }

    //タブの作成
    //タイトルの作成
    override var titlesInSwitcher: [String]{
        return ["TOP","AbemaNews","Yahoo","IT","Buzz","CNN",]
    }
    
    //タブごとにコントローラーを返す（タブの下の各コントローラーを配置する）
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
        case 0:
            return Page1ViewController()
        case 1:
            return Page2ViewController()
        case 2:
            return Page3ViewController()
        case 3:
            return Page4ViewController()
        case 4:
            return Page5ViewController()
        case 5:
            return Page6ViewController()
        default:
            return Page1ViewController()
        }
    }
    

}
