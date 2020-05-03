//
//  AlertUtil.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/26.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlertActionSheet(action1:@escaping () -> Void, action2:@escaping () -> Void){
        let alert = UIAlertController(title: "アラート表示",
                                      message: "保存しますか？",
                                      preferredStyle: UIAlertController.Style.actionSheet)
        let imgPickerAction = UIAlertAction(title: "写真を選択",
                                            style: UIAlertAction.Style.default,
                                            handler: {
                                                (alert) -> Void in
                                                action1()
                                                print("写真を選択するよ〜")
        })
        let cameraAction = UIAlertAction(title: "カメラ起動",
                                         style: UIAlertAction.Style.default,
                                         handler: {
                                            (alert) -> Void in
                                            action2()
                                            print("カメラ撮影するよ〜")
        })
        let cancelAction = UIAlertAction(title: "キャンセル",
                                         style: UIAlertAction.Style.cancel,
                                         handler: {
                                         (action: UIAlertAction!) -> Void in
                                            print("キャンセル押したよ〜")
        })
        alert.addAction(imgPickerAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        present(alert, animated:true, completion: nil)
    }
    
    func showAlert(action: @escaping () -> Void) {
        let alert = UIAlertController(title: "アラート表示",
                                      message: "保存してもよろしいですか？",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: UIAlertAction.Style.default,
                                     handler: {(alert) -> Void in action()})
        let cancelAction = UIAlertAction(title: "キャンセル",
                                         style: UIAlertAction.Style.cancel,
                                         handler: { (alert) -> Void in print("キャンセルしました")})
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

