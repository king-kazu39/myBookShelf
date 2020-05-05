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
    private var imgStr: NSData?
    
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
            imgStr = resizeImgData(originalImg: image, width: 300)
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
        let title = "アラート表示"
        let msg = "保存しますか？"
        showAlert(alertTitle: title, alertMsg: msg) {
            MyBookCRUD.myBookCreate(image: self.imgStr ??
                                   (UIImage(named: "book-icon")?.pngData()!)! as NSData,
                                    title: (self.registerView?.bookTitleTextField?.text)!,
                                    category: self.registerView?.categoryTextField?.text ?? "",
                                    boughtAt: self.registerView?.boughtAtTextField?.text ?? "")
            
            self.showAlert(alertTitle: "成功", alertMsg: "登録完了しました") {
                self.navigationController?.popToRootViewController(animated: true)
            }
            print("登録します")
        }
    }
    
    func resizeImgData(originalImg: UIImage, width: Double) -> NSData {
        var imageData = originalImg.pngData()
        
        if (imageData!.count) > 1000000 {
            
            let aspectScale = originalImg.size.height / originalImg.size.width
            let resizedSize = CGSize(width: width, height: width * Double(aspectScale))
            UIGraphicsBeginImageContext(resizedSize)
            originalImg.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
            let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            
            imageData = resizedImg?.pngData()
        }
        
        return (imageData as NSData?)!
    }
}
