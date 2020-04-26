//
//  MyBookRegisterViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/26.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

class MyBookRegisterViewController: UIViewController, RegisterProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MyBookRegister"
        let rect = CGRect(x: 0, y: 0, width: 250, height: 400)
        
        let registerView = RegisterView(frame: rect)
            registerView.center = view.center
        self.view.addSubview(registerView)
        registerView.delegate = self
        
    }
    
    
    func didTapAlertAction(button: UIButton) {
        showAlertAction()
    }

}
