//
//  RegisterViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/25.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

class WishListSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "myBookShelf"
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let label = UILabel(frame: rect)
        label.center = self.view.center
        label.text = "SecondViewController"
        label.textColor = UIColor.black
        label.font = UIFont(name: "HiraKakuProN-W6", size: 17)
        view.backgroundColor = .white
        self.view.addSubview(label)
    }
    

}
