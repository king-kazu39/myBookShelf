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
class MyBookSearchViewController: UIViewController {
    
    var rightBtn: UIBarButtonItem?
    private var tableView: UITableView?
    private var myBookData: Results<MyBook> = MyBookCRUD.myBookAllSelectDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "myBookShelf"
        rightBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClick))
        self.navigationItem.rightBarButtonItem = rightBtn
        
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.allowsSelection = false
        tableView?.register(MyBookTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView!)
        
        print(myBookData.count)
        
    }
    
    @objc func onClick(){
        let nextVC = MyBookRegisterViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
        
        if myBookData.count == 0 {
            tableView?.isHidden = true
            setOnlyTextInNoTableView()
        } else {
            tableView?.isHidden = false
        }
    }
    
    private func setOnlyTextInNoTableView(){
        let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
        let label = UILabel(frame: rect)
        label.center = self.view.center
        label.text = "MyBookSearchViewController"
        label.textColor = UIColor.black
        label.font = UIFont(name: "HiraKakuProN-W6", size: 17)
        view.backgroundColor = .white
        self.view.addSubview(label)
    }
    
}

extension MyBookSearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.myBookData.count == 0 {
            return 1
        } else {
            return myBookData.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyBookTableViewCell
        if self.myBookData.count == 0 {
            let textNoCell = cell.viewWithTag(1) as! UILabel
            textNoCell.text = "データがありません"
            return cell
        } else {
            let bookTitle = cell.viewWithTag(1) as! UILabel
            let bookImg = cell.viewWithTag(2) as! UIImageView
            let bookCategory = cell.viewWithTag(3) as! UILabel
            let bookBoughtAt = cell.viewWithTag(4) as! UILabel
            bookTitle.text = myBookData[indexPath.row].title
            bookImg.image = UIImage(data: (myBookData[indexPath.row].image)! as Data)
            bookCategory.text = myBookData[indexPath.row].category
            bookBoughtAt.text = myBookData[indexPath.row].bought_at
            return cell
        }
    }

}
