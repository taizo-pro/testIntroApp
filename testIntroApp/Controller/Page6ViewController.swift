//
//  Page2ViewController.swift
//  testIntroApp
//
//  Created by Kazuki Harada on 2020/05/21.
//  Copyright © 2020 Harada Kazuki. All rights reserved.
//

import UIKit
import SegementSlide

class Page6ViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    
    //XMLParserをインスタンス化する
    var parser = XMLParser()
    
    //RSSのパース中の現在の要素名
    var currentElementName:String!
    
    //NewsItemsが入る配列
    var newsItems = [NewsItems]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //背景に画像を入れる
        tableView.backgroundColor = .clear
        //画像"5"をTableViewの下に置く
        let image = UIImage(named: "5")
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height)
        //画像を反映させる
        imageView.image = image
        
        self.tableView.backgroundView = imageView
        
        
        //XMLパース
        parser.delegate = self
        //取得するXMLを宣言する
        let urlString = "https://news.yahoo.co.jp/pickup/rss.xml"
        //String型のurlをURL型にキャスティング
        let url:URL = URL(string: urlString)!
        //parserにURL型のurlを渡す
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
        //newsItemsのパースが完了している状態
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
    
    //セルがタップされたときに呼ばれる
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //WebViewControllerにurlを渡して、表示する
        //WebViewControllerを作成
        let webViewController = WebViewController()
        webViewController.modalTransitionStyle = .crossDissolve
        //何番目に呼ぶか指定する
        let newsItem = newsItems[indexPath.row]
        //newsItem.urlをアプリ内に保存する、"url"キーで
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        //表示させるもの
        present(webViewController, animated: true, completion: nil)
    }
    
    //XMLの開始タグを受け取るためのメソッド
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        if elementName == "item"{
            //NewsItemsの中を初期化→値を入れる準備をして、newsItemsの中に入れる
            self.newsItems.append(NewsItems())
        }else{
            currentElementName = elementName
        }
    }
    
    //文字列（値）を受け取るためのメソッド
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0{
            let lastItem = self.newsItems[self.newsItems.count - 1]
            //欲しい要素を取得する
            switch self.currentElementName {
            //要素がtitleの場合、値を取得する
            case "title":
                lastItem.title = string
            //要素がlinkの場合、値を取得する
            case "link":
                lastItem.url = string
            //要素がpubDateの場合、値を取得する
            case "pubDate":
                lastItem.pubDate = string
            default:
                break;
            }
        }
    }
    
    //終了タグを受け取るためのメソッド
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
    }
    
    //解析終了時のメソッド
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }
}



