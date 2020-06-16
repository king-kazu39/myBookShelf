//
//  MyBookCRUD.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/05/04.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import Foundation
import RealmSwift

class MyBookCRUD {
    
    static func createMyBook(_ image: NSData, _ title: String, _ category: String?, _ boughtAt: String?){
        let realm = try! Realm()
        let myBook = MyBook()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        myBook.image = image
        myBook.title = title
        myBook.category = category ?? ""
        myBook.bought_at = boughtAt ?? ""
        
        try! realm.write() {
            realm.add(myBook)
        }
    }
    
    static func selectAllOfMyBook() -> Results<MyBook> {
        let realm = try! Realm()
        return realm.objects(MyBook.self)
    }
    
    // 書籍タイトルで絞り込み検索したときの検索結果を返すメソッド
    static func filterResultsWithBookName(_ bookTitle: String) -> Results<MyBook> {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "title CONTAINS %@", bookTitle)
        return realm.objects(MyBook.self).filter(predicate).sorted(byKeyPath: "bought_at")
    }
}
