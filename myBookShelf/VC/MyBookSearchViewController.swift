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

let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

// final:RootVCクラスを継承したクラスを作ることを禁止します
class MyBookSearchViewController: UIViewController, EmptyStateDelegate, UISearchBarDelegate {
    
    private var addBarButtonItem: UIBarButtonItem?
    private var mySearchBar: UISearchBar = UISearchBar()
    private var myLabel: UILabel!
    private var tableView: UITableView?
//    private var collectionView: UICollectionView?
    private var myBookData: Results<MyBook>?
    private var mySegment: UISegmentedControl = UISegmentedControl()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenSize.width / 2.0, height: screenSize.height), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MyBookCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "myBookShelf"
        
        //サーチバー作成
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
        
        //collectionView
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        //        collectionView.register(MyBookCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(mySearchBar)
        self.view.addSubview(myLabel)
        self.view.addSubview(tableView!)
        self.view.addSubview(collectionView)
        
        // SegmentedControl
        setSegmentedControl()
        
        print(myBookData?.count)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(self.view.safeAreaInsets.top)
        
        mySearchBar.frame = CGRect(x: 0,
                                   y: self.view.safeAreaInsets.top,
                                   width: view.bounds.width,
                                   height: 50)
        
        mySegment.frame = CGRect(x: 30,
                                  y: self.view.safeAreaInsets.top + mySearchBar.bounds.height + 10,
                                  width: view.bounds.width - 30 * 2,
                                  height: 40)
        
        tableView?.frame = CGRect(x: 0,
                                  y: self.view.safeAreaInsets.top
                                   + mySearchBar.bounds.height
                                   + mySegment.bounds.height
                                   + 20,
                                  width: view.bounds.width,
                                  height: view.bounds.height - (self.view.safeAreaInsets.top + mySearchBar.bounds.height + mySegment.bounds.height + 20))
        
        collectionView.frame = CGRect(x: 0,
                                  y: self.view.safeAreaInsets.top
                                   + mySearchBar.bounds.height
                                   + mySegment.bounds.height
                                   + 20,
                                  width: view.bounds.width,
                                  height: view.bounds.height - (self.view.safeAreaInsets.top + mySearchBar.bounds.height + mySegment.bounds.height))
        
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
        collectionView.reloadData()
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
        collectionView.reloadData()
        
        if myBookData?.count == 0 {
            tableView?.isHidden = true
            collectionView.isHidden = true
            mySearchBar.isHidden = false
            view.emptyState.show(State.noSearch)
            view.emptyState.format.buttonWidth = 100
        } else {
            addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped(_:)))
            self.navigationItem.rightBarButtonItem = addBarButtonItem
            tableView?.isHidden = false
            collectionView.isHidden = true
        }
    }
    
    private func setSegmentedControl(){
        mySegment = UISegmentedControl(items: ["リスト表示","一覧表示"])
        mySegment.tintColor = UIColor(red: 0.13, green: 0.61, blue: 0.93, alpha: 1.0)
        mySegment.backgroundColor = UIColor(red: 0.96, green: 0.98, blue: 1.00, alpha: 1.0)
        mySegment.setTitleTextAttributes([NSAttributedString.Key.font:UIFont(name: "HiraKakuProN-W6", size: 14.0)!,NSAttributedString.Key.foregroundColor:UIColor.blue], for: .selected)
        mySegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "HiraKakuPro-W3", size: 14.0)!,NSAttributedString.Key.foregroundColor: UIColor(red: 0.30, green: 0.49, blue: 0.62, alpha: 1.0)], for: .normal)
        mySegment.selectedSegmentIndex = 0
        mySegment.addTarget(self, action: #selector(segmentedChange(_:)), for: .valueChanged)
        self.view.addSubview(mySegment)
    }
    
    @objc func segmentedChange(_ segment: UISegmentedControl){
        switch segment.selectedSegmentIndex {
        case 0:
            print("リスト表示")
            tableView?.isHidden = false
            collectionView.isHidden = true
        case 1:
            print("一覧表示")
            tableView?.isHidden = true
            collectionView.isHidden = false
        default:
            break
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

extension MyBookSearchViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myBookData?.count == 0 {
            return 1
        } else {
            return myBookData!.count
        }
    }
    
    //セルの大きさ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width / 2.0, height: screenSize.width / 2.0)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath) as! MyBookCollectionViewCell
        if myBookData?.count == 0 {
            let cellText = "No Image"
            let cellImage = UIImage(named: "book-icon")
            cell.setUpContents(cellImage!, cellText)
            return cell
        } else {
            let cellImage = UIImage(data: (myBookData?[indexPath.row].image)! as Data)
            let cellText = myBookData?[indexPath.row].title
            cell.setUpContents(cellImage!, cellText!)
            return cell
        }
    }


}
