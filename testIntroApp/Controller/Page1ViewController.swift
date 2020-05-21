//
//  Page1ViewController.swift
//  testIntroApp
//
//  Created by Kazuki Harada on 2020/05/21.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import SegementSlide

class Page1ViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    
    //XMLParserをインスタンス化する
    var parser = XMLParser()
    
    //RSSのパース中の現在の要素名
    var currentElementName:String
    
    //NewsItemsが入る配列
    var newsItems = [NewsItems]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //背景に画像を入れる
        tableView.backgroundColor = .clear
        //画像"0"をTableViewの下に置く
        let image = UIImage(named: "0")
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height)
        //画像を反映させる
        imageView.image = image
        
        self.tableView.backgroundView = imageView
        
        
        //XMLパース
        parser.delegate = self
        let urlString = "https://news.yahoo.co.jp/pickup/rss.xml"
        let url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        //パースを開始する
        parser.parse()
    }

    //TableViewを返す
    @objc var scrollView: UIScrollView{
        return tableView
    }
    
    //セルのセクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return view.frame.size.height / 5
    }

    //セルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    //セルの値
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //スタイルをsubtitleにして、2行にする
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.backgroundColor = .clear
        
        let newsItem = self.newsItems[indexPath.row]
        //セルに表示する値を設定する
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3
        //2行目
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
    //パースを開始します
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item"{
            self.newsItems.append(NewsItems())
        }else{
            currentElementName = elementName
        }
    }
}
