//
//  RegisterView.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/26.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

protocol RegisterProtocol: class {
    func didTapAlertAction(button: UIButton)
    func didTapRegister(button: UIButton)
}

class RegisterView: UIView {

    var imageBtn: UIButton?
    var image0:UIImage? = UIImage(named: "camera-icon")
    
    var bookTitleTextField: UITextField?
    var categoryTextField: UITextField?
    var boughtAtTextField: DatePickerKeyboard?
//    var datePicker: DatePickerKeyboard?
    var sendBtn: UIButton?
    
    weak var delegate: RegisterProtocol? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImgBtn()
        self.setBookTitleTextField()
        self.setCategoryTextField()
        self.setBoughtAtTextField()
        self.setSendBtn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setImgBtn(){
        imageBtn = UIButton()
        imageBtn?.setImage(image0, for: .normal)
        imageBtn?.contentMode = .scaleAspectFit
        imageBtn?.addTarget(self, action: #selector(pushAlert(_:)), for: .touchUpInside)
        self.addSubview(imageBtn!)
    }
    
    @objc func pushAlert(_ sender: UIButton){
        print("アラート出すよ〜")
        self.delegate?.didTapAlertAction(button: sender)
        
    }
    
    func setBookTitleTextField(){
        bookTitleTextField = UITextField()
        bookTitleTextField?.borderStyle = .roundedRect
        bookTitleTextField?.layer.cornerRadius = 5
        bookTitleTextField?.clipsToBounds = true
        bookTitleTextField?.tag = 1
        bookTitleTextField?.placeholder = "タイトルを入力してください"
        self.addSubview(bookTitleTextField!)
    }
    
    func setCategoryTextField() {
        categoryTextField = UITextField()
        categoryTextField?.borderStyle = .roundedRect
        categoryTextField?.layer.cornerRadius = 5
        categoryTextField?.clipsToBounds = true
        categoryTextField?.tag = 2
        categoryTextField?.placeholder = "カテゴリを選択してください"
        self.addSubview(categoryTextField!)
    }
    
    func setBoughtAtTextField() {
        boughtAtTextField = DatePickerKeyboard()
        boughtAtTextField?.borderStyle = .roundedRect
        boughtAtTextField?.layer.cornerRadius = 5
        boughtAtTextField?.clipsToBounds = true
        boughtAtTextField?.tag = 3
        boughtAtTextField?.placeholder = "購入日を選択してください"
        self.addSubview(boughtAtTextField!)
    }
    
    private func setSendBtn(){
        sendBtn = UIButton()
        sendBtn?.setTitle("登録する", for: UIControl.State.normal)
        sendBtn?.addTarget(self, action: #selector(tapRegisterBtn(_:)), for: .touchUpInside)
        sendBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        sendBtn?.backgroundColor = .blue
        sendBtn?.layer.cornerRadius = 10
        sendBtn?.clipsToBounds = true
        self.addSubview(sendBtn!)
    }
    
    @objc func tapRegisterBtn(_ sender: UIButton) {
        self.delegate?.didTapRegister(button: sender)
        print("登録するよ〜")
    }
    
    override func layoutSubviews() {
        imageBtn?.frame = CGRect(x: bounds.size.width / 4,
                                 y: 0,
                                 width: bounds.size.width / 2,
                                 height: 100)
        
        bookTitleTextField?.frame = CGRect(x: 0,
                                           y: (imageBtn?.frame.height)! + 20,
                                           width: bounds.size.width,
                                           height: 40)
        
        categoryTextField?.frame = CGRect(x: 0,
                                          y: (imageBtn?.frame.height)! + 80,
                                           width: bounds.size.width,
                                           height: 40)
        
        boughtAtTextField?.frame = CGRect(x: 0,
                                          y: (imageBtn?.frame.height)! + 140,
                                          width: bounds.size.width,
                                          height: 40)
        
        sendBtn?.frame = CGRect(x: bounds.size.width / 4,
                                y: (imageBtn?.frame.height)! + 200,
                                width: bounds.size.width / 2,
                                height: 60)
        
    }
    
}
