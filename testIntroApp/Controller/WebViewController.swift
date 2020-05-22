//
//  WebViewController.swift
//  testIntroApp
//
//  Created by Kazuki Harada on 2020/05/22.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate{

    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 50)
        view.addSubview(webView)
        
        //アプリ内保存した情報を取り出す
        let urlString = UserDefaults.standard.object(forKey: "url")
        //String型のurlStringをURL型にキャスティングする
        let url = URL(string: urlString as! String)
        //リクエストするための準備
        let request = URLRequest(url: url!)
        //ロードをする
        webView.load(request)
        
        
    }
    


}
