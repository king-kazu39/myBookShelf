//
//  HomeViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/25.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit
import RealmSwift

/*
 [Swift 5]RootViewControllerを適用する備忘録
 https://qiita.com/Riscait/items/29e34d922dad834106da
 */

// final:RootVCクラスを継承したクラスを作ることを禁止します
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "myBookShelf"
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let label = UILabel(frame: rect)
        label.center = self.view.center
        label.text = "FirstViewController"
        label.textColor = UIColor.black
        label.font = UIFont(name: "HiraKakuProN-W6", size: 17)
        view.backgroundColor = .white
        self.view.addSubview(label)
        
        let myBook = MyBook()
        myBook.title = "Realm入門"
        myBook.category = "技術参考書"
        myBook.bought_at = 20191212
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(myBook)
        }
        
        let books = realm.objects(MyBook.self)
        for book in books {
            print("title: \(book.title)")
            print("category: \(book.category)")
            print("bought_at: \(book.bought_at)")
        }
        
    }
    
}
