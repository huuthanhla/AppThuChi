//
//  ScrRegister.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 1/2/17.
//  Copyright © 2017 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class ScrRegister:BaseViewController
{
    var arrTxt:Array<UITextField> = Array<UITextField>()
    var heightViewBackground:NSLayoutConstraint!
    let txtEmail:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 0
            txt.autocapitalizationType = .none
            return txt
    }()
    let txtFullName:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 2
            txt.autocapitalizationType = .words
            return txt
    }()
    let txtPassword:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 1
            txt.isSecureTextEntry = true
            return txt
    }()
    
    let imgAvatar:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.image = #imageLiteral(resourceName: "photo-camera")
            img.contentMode = .scaleAspectFit
            img.clipsToBounds = true
            return img
    }()
    
    let btnRegister:UIButton =
        {
            let btn:UIButton = UIButton()
            btn.setUp()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Đăng Ký", for: UIControlState.normal)
            return btn
    }()
    
    let imgIcon:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFit
            img.image = #imageLiteral(resourceName: "Icon1png")
            return img
    }()
    
    let viewBackground:UIView = {
        let view:UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2007437928)
        view.clipsToBounds = true
        return view
    }()
    
    override func setUp() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpNavigation()
        setUpViewBackground()
        setUpImgIcon()
        setUpTxt()
        setUpImgAvatar()
        setUpBtn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animation()
    }
    
    func setUpImgIcon()
    {
        self.view.addSubview(imgIcon)
        imgIcon.centerXAnchor.constraint(equalTo: self.viewBackground.centerXAnchor).isActive = true
        imgIcon.bottomAnchor.constraint(equalTo: self.viewBackground.topAnchor).isActive = true
        imgIcon.widthAnchor.constraint(equalTo: self.viewBackground.widthAnchor, multiplier: 1/4).isActive = true
        imgIcon.heightAnchor.constraint(equalTo: imgIcon.widthAnchor).isActive = true
        imgIcon.alpha = 0
        
    }
    
    func setUpImgAvatar()
    {
        view.addSubview(imgAvatar)
        imgAvatar.topAnchor.constraint(equalTo: txtFullName.bottomAnchor, constant: 10).isActive = true
        imgAvatar.centerXAnchor.constraint(equalTo: txtFullName.centerXAnchor).isActive = true
        imgAvatar.widthAnchor.constraint(equalTo: txtFullName.widthAnchor, multiplier: 1/2).isActive = true
        imgAvatar.heightAnchor.constraint(equalTo: imgAvatar.widthAnchor).isActive = true
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScrRegister.tapImgAvatar))
        imgAvatar.addGestureRecognizer(tapGesture)
        imgAvatar.isUserInteractionEnabled = true
    }
    
    func setUpNavigation()
    {
        navigationItem.title = "Đăng Ký"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSFontAttributeName:UIFont(name: "Times New Roman", size: 20)!]
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setUpViewBackground()
    {
        self.view.addSubview(viewBackground)
        viewBackground.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewBackground.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        viewBackground.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5).isActive = true
        heightViewBackground = viewBackground.heightAnchor.constraint(equalToConstant: 0)
        heightViewBackground.isActive = true
        viewBackground.layer.cornerRadius = 10
        viewBackground.alpha = 1
    }
    
    func setUpTxt()
    {
        arrTxt = [txtEmail, txtPassword, txtFullName]
        let arrPlaceHolder:Array<String> = ["✉️ Địa chỉ email", "🔒 Mật khẩu", "😀 Họ và tên"]
        self.view.addSubview(txtEmail)
        txtEmail.topAnchor.constraint(equalTo: self.viewBackground.topAnchor, constant: 20).isActive = true
        txtEmail.centerXAnchor.constraint(equalTo: self.viewBackground.centerXAnchor).isActive = true
        txtEmail.widthAnchor.constraint(equalTo: self.viewBackground.widthAnchor, multiplier: 5/6).isActive = true
        txtEmail.heightAnchor.constraint(equalToConstant: 30).isActive = true
        txtEmail.placeholder = arrPlaceHolder[0]
        txtEmail.alpha = 0
        txtEmail.delegate = self
        for i in 1..<arrTxt.count
        {
            self.view.addSubview(arrTxt[i])
            arrTxt[i].topAnchor.constraint(equalTo: arrTxt[i-1].bottomAnchor, constant: 10).isActive = true
            arrTxt[i].leftAnchor.constraint(equalTo: arrTxt[i-1].leftAnchor).isActive = true
            arrTxt[i].rightAnchor.constraint(equalTo: arrTxt[i-1].rightAnchor).isActive = true
            arrTxt[i].heightAnchor.constraint(equalTo: arrTxt[i-1].heightAnchor).isActive = true
            arrTxt[i].placeholder = arrPlaceHolder[i]
            arrTxt[i].alpha = 0
            arrTxt[i].delegate = self
        }
    }
    
    func setUpBtn()
    {
        self.view.addSubview(btnRegister)
        btnRegister.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant: 10).isActive = true
        btnRegister.leftAnchor.constraint(equalTo: imgAvatar.leftAnchor).isActive = true
        btnRegister.rightAnchor.constraint(equalTo: imgAvatar.rightAnchor).isActive = true
        btnRegister.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnRegister.alpha = 0
        btnRegister.addTarget(self, action: #selector(ScrRegister.tapBtnRegister), for: UIControlEvents.touchUpInside)
    }
    
    func tapBtnRegister()
    {
        for i in arrTxt
        {
            i.setNormal()
        }
        if validTxt().count == 0
        {
            let alert:ViewAlertAlert = ViewAlertAlert()
            alert.show(view: self.view)
            register(email: txtEmail.text!, password: txtPassword.text!, fullName: txtFullName.text!, avatar: imgAvatar.image!, alert: alert)
        }
        else
        {
            for i in validTxt()
            {
                for j in arrTxt
                {
                    if i == j.tag
                    {
                        j.setError()
                    }
                }
            }
        }
    }
    
    func tapImgAvatar()
    {
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        let alert:UIAlertController = UIAlertController(title: "Vui lòng chọn", message: "Chọn ảnh đại diện", preferredStyle: UIAlertControllerStyle.alert)
        
        let btnCamera:UIAlertAction = UIAlertAction(title: "Máy Ảnh", style: UIAlertActionStyle.destructive) { (btn) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                picker.sourceType = .camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            }
            else
            {
                print("No camera")
            }
        }
        
        let btnPhoto:UIAlertAction = UIAlertAction(title: "Thư viện", style: UIAlertActionStyle.destructive) { (btn) in
            
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
            self.present(picker, animated: true, completion: nil)
        }
        
        let btnCancel:UIAlertAction = UIAlertAction(title: "Huỷ", style: .default) { (btn) in
        }
        
        alert.addAction(arr: btnPhoto, btnCamera, btnCancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func animation()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.imgIcon.alpha = 1
        }) { (true) in
            self.rotationImgIcon()
            UIView.animate(withDuration: 0.3, delay: 0.2, options: UIViewAnimationOptions.curveLinear, animations: {
                self.heightViewBackground.constant = CGFloat((self.arrTxt.count + 1) * 40 + 10) + 5/12 * self.view.frame.width
                self.view.layoutSubviews()
            }, completion: { (true) in
                UIView.animate(withDuration: 0.1, animations: { 
                    for i in self.arrTxt
                    {
                        i.alpha = 1
                    }
                    self.btnRegister.alpha = 1
                })
            })
        }
        
    }
    
    
    
    func rotationImgIcon()
    {
        UIView.animate(withDuration: 0.125, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            self.imgIcon.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI), 0, 1, 0)
        }, completion: { (true) in
            UIView.animate(withDuration: 0.125, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                self.imgIcon.layer.transform = CATransform3DMakeRotation(CGFloat(-2*M_PI), 0, 1, 0)
            }, completion: { (true) in
                
                UIView.animate(withDuration: 0.125, delay: 0, options: .curveLinear, animations: {
                    self.imgIcon.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI), 0, 1, 0)
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.125, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                        self.imgIcon.layer.transform = CATransform3DMakeRotation(CGFloat(-2*M_PI), 0, 1, 0)
                    }, completion: nil)
                })
            })
        })
        
    }
    
    func validTxt()->Array<Int>
    {
        var arr:Array<Int> = Array<Int>()
        if !txtEmail.validString()
        {
            arr.append(txtEmail.tag)
        }
        if !txtPassword.validString()
        {
            arr.append(txtPassword.tag)
        }
        if !txtFullName.validString()
        {
            arr.append(txtFullName.tag)
        }
        return arr
    }

}

extension ScrRegister:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
extension ScrRegister:UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image:UIImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imgAvatar.image = image
            dismiss(animated: true, completion: nil)
        }
        else
        {
            if let image:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                imgAvatar.image = image
                dismiss(animated: true, completion: nil)
            }
            else
            {
                dismiss(animated: true, completion: nil)
                let alert:UIAlertController = UIAlertController(title: "Lỗi", message: "Chọn sai định dạng", preferredStyle: UIAlertControllerStyle.alert)
                let btnOk:UIAlertAction = UIAlertAction(title: "Đồng Ý", style: .cancel, handler: nil)
                alert.addAction(btnOk)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
