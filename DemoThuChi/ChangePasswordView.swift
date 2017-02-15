//
//  ChangePasswordView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 1/9/17.
//  Copyright © 2017 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class ChangePasswordView: BaseView {
    
    var arrTxt:Array<UITextField> = Array<UITextField>()
    
    let viewBackGround:UIView = {
        let view:UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    let viewChangePass:UIView = {
        let view:UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let txtOldPassword:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.setUp()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.tag = 0
            txt.isSecureTextEntry = true
            return txt
    }()
    
    let txtPassword:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.setUp()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.tag = 1
            txt.isSecureTextEntry = true
            return txt
    }()
    
    let txtPrePassword:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.setUp()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.tag = 2
            txt.isSecureTextEntry = true
            return txt
    }()
    
    let btnOk:UIButton =
        {
            let btn:UIButton = UIButton()
            btn.setUp()
            btn.setTitle("Đồng Ý", for: UIControlState.normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
    }()
    
    override func setUp() {
        
        setUpViewBackground()
        setUpViewChangePass()
        setUpTxt()
        setUpBtnOk()
    }
    
    func setUpViewBackground()
    {
        self.addSubview(viewBackGround)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: ["v0":viewBackGround]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: [], metrics: nil, views: ["v0":viewBackGround]))
    }
    
    func setUpViewChangePass()
    {
        self.addSubview(viewChangePass)
        viewChangePass.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewChangePass.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewChangePass.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true
    }
    
    func setUpTxt()
    {
        arrTxt = [txtOldPassword, txtPassword, txtPrePassword]
        let arrPlaceHolder:Array<String> = ["🔐 Mật khẩu cũ", "🔒 Mật khẩu mới", "🔒 Nhập lại mật khẩu"]
        self.addSubview(txtOldPassword)
        txtOldPassword.centerXAnchor.constraint(equalTo: viewChangePass.centerXAnchor).isActive = true
        txtOldPassword.topAnchor.constraint(equalTo: viewChangePass.topAnchor, constant: 20).isActive = true
        txtOldPassword.widthAnchor.constraint(equalTo: viewChangePass.widthAnchor, multiplier: 5/6).isActive = true
        txtOldPassword.heightAnchor.constraint(equalToConstant: 30).isActive = true
        txtOldPassword.placeholder = arrPlaceHolder[0]
        
        for i in 1..<arrTxt.count
        {
            self.addSubview(arrTxt[i])
            arrTxt[i].leftAnchor.constraint(equalTo: arrTxt[i-1].leftAnchor).isActive = true
            arrTxt[i].rightAnchor.constraint(equalTo: arrTxt[i-1].rightAnchor).isActive = true
            arrTxt[i].topAnchor.constraint(equalTo: arrTxt[i-1].bottomAnchor, constant: 10).isActive = true
            arrTxt[i].heightAnchor.constraint(equalTo: arrTxt[i-1].heightAnchor).isActive = true
            arrTxt[i].placeholder = arrPlaceHolder[i]
        }
        
    }
    
    func setUpBtnOk()
    {
        self.addSubview(btnOk)
        btnOk.topAnchor.constraint(equalTo: txtPrePassword.bottomAnchor, constant: 10).isActive = true
        btnOk.centerXAnchor.constraint(equalTo: txtPrePassword.centerXAnchor).isActive = true
        btnOk.widthAnchor.constraint(equalTo: txtPrePassword.widthAnchor, multiplier: 1/2).isActive = true
        btnOk.heightAnchor.constraint(equalTo: txtPrePassword.heightAnchor).isActive = true
        btnOk.bottomAnchor.constraint(equalTo: viewChangePass.bottomAnchor, constant: -20).isActive = true
        btnOk.layer.cornerRadius = 5
        btnOk.clipsToBounds = true
       
    }
    
    func reset()
    {
        for i in arrTxt
        {
            i.text = ""
        }
    }
    
    func validTxt()->Array<Int>
    {
        var arr:Array<Int> = Array<Int>()
        if !txtOldPassword.validString()
        {
           arr.append(txtOldPassword.tag)
        }
        if !txtPassword.validString()
        {
            arr.append(txtPassword.tag)
        }
        if !txtPrePassword.validString()
        {
            arr.append(txtPrePassword.tag)
        }
        
        if txtPrePassword.validString() && txtPassword.validString()
        {
            if txtPassword.text != txtPrePassword.text
            {
                arr.append(txtPassword.tag)
                arr.append(txtPrePassword.tag)
            }
        }
        
        return arr
        
    }
}
