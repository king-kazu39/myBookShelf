//
//  TextFieldViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/05/03.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import Foundation
import UIKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {

    private var activeTextField: UITextField?
    private var initialized: Bool = false
    private var resetSize: Void {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialized = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !initialized else { return }
        
        // 全てのテキストフィールドにdelegate設定
        setDelegate()
    }
    
    private func getAllTextFields(fromView view: UIView) -> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            return (view is UITextField) ? [(view as! UITextField)] : getAllTextFields(fromView: view)
        }.flatMap({$0})
    }
    
    private func setDelegate(){
        let textFileds = getAllTextFields(fromView: self.view)
        for textFiled in textFileds {
            textFiled.delegate = self
        }
        initialized = true
    }

    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.activeTextField = textField
        return true
    }

    internal func setUpNotificationForTextField() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(self.handleKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // テキストフィールド外をタップしてキーボードを非表示にする
    internal override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((activeTextField?.isFirstResponder) != nil) {
            activeTextField?.resignFirstResponder()
        }
    }

    @objc private func handleKeyboardWillShowNotification(_ notification: Notification) {
        let userInfo = notification.userInfo //この中にキーボードの情報がある
        let keyboardSize = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height //画面全体の高さ - キーボードの高さ = キーボードが被らない高さ
        if CGFloat(0) != self.view.frame.origin.y {
            self.resetSize
        }
        guard let editingTextFieldY = self.activeTextField?.frame.origin.y else { return }
        
        if editingTextFieldY > keyboardY - 120 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: 0 - (editingTextFieldY - (keyboardY - 180)), width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)

        }
    }

    @objc private func handleKeyboardWillHideNotification(_ notification: Notification) {
        self.resetSize
    }
}
