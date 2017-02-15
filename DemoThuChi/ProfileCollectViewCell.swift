//
//  ProfileCell.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 1/5/17.
//  Copyright © 2017 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit
class ProfileCollectViewCell:BaseCollectionViewCell
{
    var centerY:NSLayoutConstraint!
    let lblTitle:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.setUpLblTitle(title: "Thông Tin Tài Khoản", txtColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), fontSize: 20, cornerRadius: nil, textAlignment: NSTextAlignment.center)
            lbl.font = lbl.font.withTraits(traits: .traitBold)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
    }()
    
    let lblFullName:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.setUpLblTitle(title: "Xin chào: \(currentUser.fullName)!", txtColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), fontSize: 15, cornerRadius: nil, textAlignment: NSTextAlignment.center)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
    }()
    
    let imgAvatar:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.clipsToBounds = true
            img.image = #imageLiteral(resourceName: "avatar")
            img.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            if let i = currentUser.avatar
            {
                img.image = i
                currentUser.avatar = i
            }
            else
            {
                img.loadImage(link: currentUser.urlAvatar)
            }
            return img
    }()
    
    let btnLogOut:UIButton = {
        let btn:UIButton = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setUp()
        btn.titleLabel?.font = UIFont(name: "Times New Roman", size: 15)
        btn.setTitle("Đăng Xuất", for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let btnChangePassword:UIButton = {
        let btn:UIButton = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setUp()
        btn.titleLabel?.font = UIFont(name: "Times New Roman", size: 15)
        btn.setTitle("Đổi Mật Khẩu", for: .normal)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    let viewChangePass:ChangePasswordView =
        {
            let view:ChangePasswordView = ChangePasswordView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.clear
            return view
    }()
    
    
    override func setUp() {
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpBtn()
        setUpLblTitle()
        setUpImgAvatar()
        setUpLblFullName()
        setUpBtnChangePass()
        setUpViewChangePass()
    }
    
    func setUpLblTitle()
    {
        self.addSubview(lblTitle)
         lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblTitle.topAnchor.constraint(equalTo: btnLogOut.bottomAnchor, constant: 10).isActive = true
        lblTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        lblTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    func setUpImgAvatar()
    {
        self.addSubview(imgAvatar)
        imgAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgAvatar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        imgAvatar.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        imgAvatar.heightAnchor.constraint(equalTo: self.imgAvatar.widthAnchor).isActive = true
        imgAvatar.layer.cornerRadius = 10
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileCollectViewCell.tapPhotoCamera))
        imgAvatar.addGestureRecognizer(tapGesture)
        imgAvatar.isUserInteractionEnabled = true
    }
    
    func setUpBtn() {
        self.addSubview(btnLogOut)
        btnLogOut.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        btnLogOut.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        btnLogOut.widthAnchor.constraint(equalToConstant: 80).isActive  = true
        btnLogOut.heightAnchor.constraint(equalToConstant: 25).isActive = true
        btnLogOut.addTarget(self, action: #selector(ProfileCollectViewCell.tapBtnLogOut), for: UIControlEvents.touchUpInside)
    }
    
    func setUpLblFullName()
    {
        self.addSubview(lblFullName)
        lblFullName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblFullName.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant: 10).isActive = true
        lblFullName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        lblFullName.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    func setUpBtnChangePass()
    {
        self.addSubview(btnChangePassword)
        btnChangePassword.leftAnchor.constraint(equalTo: imgAvatar.leftAnchor).isActive = true
        btnChangePassword.rightAnchor.constraint(equalTo: imgAvatar.rightAnchor).isActive = true
        btnChangePassword.topAnchor.constraint(equalTo: lblFullName.bottomAnchor, constant: 10).isActive = true
        btnChangePassword.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnChangePassword.addTarget(self, action: #selector(ProfileCollectViewCell.tapBtnchangePass), for: UIControlEvents.touchUpInside)
    }
    
    func setUpViewChangePass()
    {
        self.addSubview(viewChangePass)
        viewChangePass.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        centerY = viewChangePass.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        centerY.isActive = true
        viewChangePass.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        viewChangePass.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileCollectViewCell.tapBtnchangePass))
        viewChangePass.viewBackGround.addGestureRecognizer(tap)
        viewChangePass.btnOk.addTarget(self, action: #selector(ProfileCollectViewCell.tapBtnOk), for: UIControlEvents.touchUpInside)
    }
    
    func tapBtnOk()
    {
        for i in viewChangePass.arrTxt
        {
            i.setNormal()
        }
        if viewChangePass.validTxt().count == 0
        {
            login(email: currentUser.email, password: viewChangePass.txtOldPassword.text!, completion: { (bool) in
                
                if bool
                {
                    let alert:ViewAlertAlert = ViewAlertAlert()
                    alert.show(view: self)
                    changePassword(pass: self.viewChangePass.txtPassword.text!, alert: alert, completion: { (err) in
                        if err == nil
                        {
                            self.tapBtnchangePass()
                        }
                    })
                }
                else
                {
                    self.viewChangePass.txtOldPassword.setError()
                }
                
            }, alert: nil)
        }
        else
        {
            for i in viewChangePass.validTxt()
            {
                for j in viewChangePass.arrTxt
                {
                    if i == j.tag
                    {
                        j.setError()
                    }
                }
            }
            
        }
    }
    
    func tapBtnLogOut()
    {
        logOut(alert: nil)
        NotificationCenter.default.post(name: NSNotification.Name.init("LogOut"), object: nil)
    }
    
    func tapBtnchangePass()
    {
        if centerY.constant == 0
        {
            centerY.constant = self.frame.height
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutSubviews()
            })
            self.viewChangePass.endEditing(true)
        }
        else
        {
            centerY.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutSubviews()
                
            })
        }
    }
    func tapPhotoCamera()
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
                NotificationCenter.default.post(name: NSNotification.Name.init("showPicker"), object: picker)
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
            NotificationCenter.default.post(name: NSNotification.Name.init("showPicker"), object: picker)
        }
        
        let btnCancel:UIAlertAction = UIAlertAction(title: "Huỷ", style: .default) { (btn) in
        }
        
        alert.addAction(arr: btnPhoto, btnCamera, btnCancel)
        
        NotificationCenter.default.post(name: Notification.Name.init("showAlert"), object: alert)
    }
}
extension ProfileCollectViewCell:UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image:UIImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imgAvatar.image = image
            let alert:ViewAlertAlert = ViewAlertAlert()
            alert.show(view: self)
            updateAvatar(image: image, alert: alert)
            NotificationCenter.default.post(name: Notification.Name.init("dismiss"), object: nil)
            
        }
        else
        {
            if let image:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                imgAvatar.image = image
                let alert:ViewAlertAlert = ViewAlertAlert()
                alert.show(view: self)
                updateAvatar(image: image, alert: alert)
                NotificationCenter.default.post(name: Notification.Name.init("dismiss"), object: nil)
            }
            else
            {
                NotificationCenter.default.post(name: Notification.Name.init("dismiss"), object: nil)
                NotificationCenter.default.post(name: Notification.Name.init("error"), object: "Chọn sai định dạng")
            }
        }
    }
}
