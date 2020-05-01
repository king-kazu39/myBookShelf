//
//  MyBookRegisterViewController.swift
//  myBookShelf
//
//  Created by 仲里和也 on 2020/04/26.
//  Copyright © 2020 仲里和也. All rights reserved.
//

import UIKit

class MyBookRegisterViewController: TextFieldViewController, RegisterProtocol,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker: UIImagePickerController = UIImagePickerController()
    var registerView: RegisterView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MyBookRegister"
        let rect = CGRect(x: 0, y: 0, width: 250, height: 400)
        
        registerView = RegisterView(frame: rect)
        registerView?.center = view.center
        self.view.addSubview(registerView!)
        registerView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNotificationForTextField()
    }
    
    
    func didTapAlertAction(button: UIButton) {
        showAlertActionSheet(action1: goToPhoto, action2: gotoCamera)
    }
    
    private func goToPhoto(){
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            registerView?.imageBtn?.setImage(image, for: .normal)
        } else {
            print("error")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func gotoCamera(){
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    
    func didTapRegister(button: UIButton) {
        showAlert {
            print("登録します")
        }
    }
}
