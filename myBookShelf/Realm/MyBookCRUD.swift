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
    
    static func myBookWrite(image: String?, title: String, category: String?, boughtAt: String?){
        let realm = try! Realm()
        let myBook = MyBook()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        myBook.image = image ?? ""
        myBook.title = title
        myBook.category = category ?? ""
        myBook.bought_at = boughtAt ?? ""
        
        try! realm.write() {
            realm.add(myBook)
        }
    }
}
