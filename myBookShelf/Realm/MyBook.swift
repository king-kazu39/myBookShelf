//
//  MyBook.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/25.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import Foundation
import RealmSwift

class MyBook: Object {
    @objc dynamic var title = ""
    @objc dynamic var image = ""
    @objc dynamic var category = ""
    @objc dynamic var bought_at = ""
}
