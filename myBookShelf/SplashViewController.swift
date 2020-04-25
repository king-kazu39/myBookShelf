//
//  ViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/24.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

/*
Twitterのような動くスプラッシュ画面をふろぐんで作ってみた
http://developers.goalist.co.jp/entry/2017/07/20/170748
*/

class SplashViewController: UIViewController {

    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 実際の表示座標は後で指定する
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView = UIImageView(frame: rect)
    
        // イメージの表示モード：
        // scaleAspectFit:画像の縦横サイズを保ったまま、イメージビューに全体が収まるようにフィットさせる
        imageView.contentMode = .scaleAspectFit
        imageView.center = self.view.center
        imageView.image = UIImage(named: "book-icon")
        view.backgroundColor = .white
        self.view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 80%まで縮小させる
        UIView.animate(withDuration: 0.3,
                       delay: 1.0,
                       options: .curveEaseOut,
                       animations:{ () in
                        self.imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)},
                       completion:{ (Bool) in
        })
        
        // 8倍まで拡大
        UIView.animate(withDuration: 0.2,
                       delay: 1.3,
                       options: .curveEaseInOut,
                       animations: { () in
                        self.imageView.transform = CGAffineTransform(scaleX: 8.0, y: 8.0)
                        self.imageView.alpha = 0
        }, completion: { (Bool) in
            // アニメーションが終わったらimageViewを消す
            self.imageView.removeFromSuperview()
            self.removeFromParent()
            let nextVC = UINavigationController(rootViewController: HomeViewController())
            /*
             サブクラスに遷移する方法
             https://qiita.com/sussan0416/items/8609fd2a06a67fd22cf0
             */
            self.addChild(nextVC)
            self.view.addSubview(nextVC.view!)
            nextVC.didMove(toParent: self)
        })
    }
    
}

