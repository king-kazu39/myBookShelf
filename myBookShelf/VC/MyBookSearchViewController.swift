//
//  HomeViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/25.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit
import RealmSwift
import EmptyStateKit

/*
 [Swift 5]RootViewControllerを適用する備忘録
 https://qiita.com/Riscait/items/29e34d922dad834106da
 */

// final:RootVCクラスを継承したクラスを作ることを禁止します
class MyBookSearchViewController: UIViewController, EmptyStateDelegate, UISearchBarDelegate {
    
    private var addBarButtonItem: UIBarButtonItem?
    private var mySearchBar: UISearchBar!
    private var myLabel: UILabel!
    private var tableView: UITableView?
    private var myBookData: Results<MyBook>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "myBookShelf"
        
        //サーチバー作成
        mySearchBar = UISearchBar()
        mySearchBar.delegate = self
        mySearchBar.showsCancelButton = true
        mySearchBar.placeholder = "本のタイトルを入力"
        
        //サーチバー確認用ラベル（後で消す）
        myLabel = UILabel()
        
        view.emptyState.delegate = self
        tableView = UITableView(frame: .zero, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
//        tableView?.allowsSelection = false
        tableView?.register(MyBookTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(mySearchBar)
        self.view.addSubview(myLabel)
        self.view.addSubview(tableView!)
        
        print(myBookData?.count)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(self.view.safeAreaInsets.top)
        mySearchBar.frame = CGRect(x: 0,
                                   y: self.view.safeAreaInsets.top,
                                   width: view.bounds.width,
                                   height: 50)
        
        tableView?.frame = CGRect(x: 0,
                                  y: self.view.safeAreaInsets.top + mySearchBar.bounds.height,
                                  width: view.bounds.width,
                                  height: view.bounds.height - (self.view.safeAreaInsets.top + mySearchBar.bounds.height))
        
        myLabel.frame = CGRect(x: 30,
                               y: 150,
                               width: view.bounds.width,
                               height: 50)
    }
    
    //サーチバー更新時(UISearchBarを関連づけておく必要がある)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        myLabel.text = mySearchBar.text
    }
    
    //キャンセルクリック時
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        myLabel.text = ""
        mySearchBar.text = ""
    }
    
    //サーチボタンクリック時
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        myLabel.text = "本のタイトル検索中"
        myBookData = MyBookCRUD.filterResultsWithBookName(mySearchBar.text ?? "")
        print(myBookData)
        mySearchBar.text = ""
        tableView!.reloadData()
        self.view.endEditing(true)
    }
    
    
    func emptyState(emptyState: EmptyState, didPressButton button: UIButton) {
        view.emptyState.hide()
        moveToNextPage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myBookData = MyBookCRUD.selectAllOfMyBook()
        tableView?.reloadData()
        
        if myBookData?.count == 0 {
            tableView?.isHidden = true
            mySearchBar.isHidden = false
            view.emptyState.show(State.noSearch)
            view.emptyState.format.buttonWidth = 100
        } else {
            addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
            self.navigationItem.rightBarButtonItem = addBarButtonItem
            tableView?.isHidden = false
        }
    }
    
    @objc func addBarButtonTapped(_ sender: UIBarButtonItem){
        moveToNextPage()
    }
    
    private func moveToNextPage(){
        let nextVC = MyBookRegisterViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MyBookSearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.myBookData?.count == 0 {
            return 1
        } else {
            return myBookData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyBookTableViewCell
        
        if self.myBookData?.count == 0 {
            let textNoCell = cell.viewWithTag(1) as! UILabel
            textNoCell.text = "データがありません"
            return cell
        } else {
            let bookTitle = cell.viewWithTag(1) as! UILabel
            let bookImg = cell.viewWithTag(2) as! UIImageView
            let bookCategory = cell.viewWithTag(3) as! UILabel
            let bookBoughtAt = cell.viewWithTag(4) as! UILabel
            bookTitle.text = myBookData?[indexPath.row].title
            bookImg.image = UIImage(data: (myBookData?[indexPath.row].image)! as Data)
            bookCategory.text = myBookData?[indexPath.row].category
            bookBoughtAt.text = myBookData?[indexPath.row].bought_at
            return cell
        }
    }

}
