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
    func showAlertAction(){
        let alert: UIAlertController = UIAlertController(title: "アラート表示",
                                                         message: "保存しますか？", preferredStyle: UIAlertController.Style.actionSheet)
        let imgPickerAction:UIAlertAction = UIAlertAction(title: "写真を選択",
                                                          style: UIAlertAction.Style.default,
                                                          handler: {
                                                            (action: UIAlertAction!) -> Void in print("写真を選択するよ〜")
        })
        let cameraAction:UIAlertAction = UIAlertAction(title: "カメラ起動",
                                                       style: UIAlertAction.Style.default,
                                                       handler: {
                                                        (action: UIAlertAction!) -> Void in print("カメラ撮影するよ〜")
        })
        let cancelAction:UIAlertAction = UIAlertAction(title: "キャンセル",
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
}

