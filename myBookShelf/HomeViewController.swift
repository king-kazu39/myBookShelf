//
//  HomeViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/25.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

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
        
    }
    
}
