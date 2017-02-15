//
//  ScrLogin.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 1/2/17.
//  Copyright © 2017 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class ScrLogin:BaseViewController
{
    var heightViewBackground:NSLayoutConstraint!
    var arrTxt:Array<UITextField> = Array<UITextField>()
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
    
    let txtUserName:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.setUp()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.tag = 0
            txt.autocapitalizationType = .none
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
    
    let btnLogin:UIButton = {
        let btn:UIButton = UIButton()
        btn.setUp()
        btn.setTitle("Đăng Nhập", for: UIControlState.normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnRegister:UIButton =
        {
            let btn:UIButton = UIButton()
            btn.setUp()
            btn.setTitle("Đăng Ký", for: UIControlState.normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
    }()
    
    override func setUp() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpNavigation()
        setUpViewBackground()
        setUpImgIcon()
        self.setUpTxt()
        self.setUpBtn()
        self.alpha(al: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        heightViewBackground.constant = 0
        viewBackground.alpha = 1
        self.alpha(al: 0)
        animation()
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.alpha(al: 0)
        imgIcon.alpha = 0
        viewBackground.alpha = 0
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
    
    func setUpNavigation()
    {
        navigationItem.title = "Đăng Nhập"
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
        arrTxt = [txtUserName, txtPassword]
        
        self.view.addSubview(txtUserName)
        txtUserName.centerXAnchor.constraint(equalTo: self.viewBackground.centerXAnchor).isActive = true
        txtUserName.topAnchor.constraint(equalTo: self.viewBackground.topAnchor, constant: 20).isActive = true
        txtUserName.widthAnchor.constraint(equalTo: viewBackground.widthAnchor, multiplier: 5/6).isActive = true
        txtUserName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(txtPassword)
        txtPassword.centerXAnchor.constraint(equalTo: self.viewBackground.centerXAnchor).isActive = true
        txtPassword.topAnchor.constraint(equalTo: self.txtUserName.bottomAnchor, constant: 10).isActive = true
        txtPassword.widthAnchor.constraint(equalTo: txtUserName.widthAnchor, multiplier: 1).isActive = true
        txtPassword.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        txtUserName.placeholder = "😀 Tên đăng nhập"
        txtPassword.placeholder = "🔒 Mật khẩu"
        txtUserName.delegate = self
        txtPassword.delegate = self
    }
    
    func setUpBtn()
    {
        view.addSubview(btnLogin)
        btnLogin.leftAnchor.constraint(equalTo: txtPassword.leftAnchor).isActive = true
        btnLogin.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 10).isActive = true
        btnLogin.widthAnchor.constraint(equalTo: txtPassword.widthAnchor, multiplier: 0.45).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnLogin.addTarget(self, action: #selector(ScrLogin.btnALogin), for: UIControlEvents.touchUpInside)
        view.addSubview(btnRegister)
        btnRegister.rightAnchor.constraint(equalTo: txtPassword.rightAnchor).isActive = true
        btnRegister.topAnchor.constraint(equalTo: btnLogin.topAnchor).isActive = true
        btnRegister.bottomAnchor.constraint(equalTo: btnLogin.bottomAnchor).isActive = true
        btnRegister.widthAnchor.constraint(equalTo: btnLogin.widthAnchor).isActive = true
        btnRegister.addTarget(self, action: #selector(ScrLogin.btnARegister), for: UIControlEvents.touchUpInside)
    }
    
    func btnALogin()
    {
        for i in arrTxt
        {
            i.setNormal()
        }
        
        if validTxt().count == 0
        {
            let alert:ViewAlertAlert = ViewAlertAlert()
            alert.show(view: self.view)
            login(email: txtUserName.text!, password: txtPassword.text!, completion: { (result) in
                if result
                {
                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = UINavigationController(rootViewController: ScrDebit())
                }

            }, alert: alert)
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
    
    func btnARegister()
    {
        let scr = ScrRegister()
        navigationController?.pushViewController(scr, animated: true)
    }
    
    func validTxt()->Array<Int>
    {
        var arr:Array<Int> = Array<Int>()
        if !txtUserName.validString()
        {
            arr.append(txtUserName.tag)
        }
        if !txtPassword.validString()
        {
            arr.append(txtPassword.tag)
        }
        
        return arr
    }
    
    func animation()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.imgIcon.alpha = 1
        }) { (true) in
            self.rotationImgIcon()
            UIView.animate(withDuration: 0.3, delay: 0.2, options: UIViewAnimationOptions.curveLinear, animations: {
                self.heightViewBackground.constant = 150
                self.view.layoutSubviews()
            }, completion: { (true) in
                
                UIView.animate(withDuration: 0.2, animations: { 
                   self.alpha(al: 1)
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
    
    func alpha(al:CGFloat)
    {
        for i in arrTxt
        {
            i.alpha = al
        }
        btnLogin.alpha = al
        btnRegister.alpha = al
    }
    
}

extension ScrLogin:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
