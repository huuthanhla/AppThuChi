//
//  ScrWellCome.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/30/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class ScrWellCome:BaseViewController
{
    
    
    let imgSetting:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFit
            img.image = #imageLiteral(resourceName: "setting")
            img.alpha = 0
            return img
    }()
    
    let imgSetting2:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFit
            img.image = #imageLiteral(resourceName: "setting 2")
            img.alpha = 0
            return img
    }()
    
    let imgIcon:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFit
            img.image = #imageLiteral(resourceName: "Icon2png")
            return img
    }()
    override func setUp() {
        self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        setUpImgSetting()
        setUpImgIcon()
        setUpImgSetting2()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        animation()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            getCurrentUser(completion: { (result) in
                if result
                {
                    let navi = UINavigationController(rootViewController: ScrDebit())
                    self.present(navi, animated: true, completion: nil)
                }
                else
                {
                    let navi = UINavigationController(rootViewController: ScrLogin())
                    self.present(navi, animated: true, completion: nil)
                }
            })
        }
    }
    
    func setUpImgSetting()
    {
        self.view.addSubview(imgSetting)
        imgSetting.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imgSetting.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        imgSetting.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3).isActive = true
        imgSetting.heightAnchor.constraint(equalTo: imgSetting.widthAnchor).isActive = true
    }
    
    func setUpImgSetting2()
    {
        self.view.addSubview(imgSetting2)
        imgSetting2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: view.frame.width/4).isActive = true
        imgSetting2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: view.frame.height / 4 + view.frame.width / 16).isActive = true
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
        {
            imgSetting2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        }
        else
        {
            imgSetting2.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4).isActive = true
        }
        imgSetting2.heightAnchor.constraint(equalTo: imgSetting2.widthAnchor).isActive = true
    }
    
    func setUpImgIcon()
    {
        self.view.addSubview(imgIcon)
        imgIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imgIcon.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        imgIcon.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        imgIcon.heightAnchor.constraint(equalTo: imgIcon.widthAnchor).isActive = true
    }
    
    func animation()
    {
        UIView.animate(withDuration: 0.2, animations: { 
            self.imgSetting.alpha = 1
            self.imgSetting2.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { 
                self.imgSetting.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
                self.imgSetting2.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
            }, completion: { (true) in
                UIView.animate(withDuration: 1.5, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { 
                    self.imgSetting.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
                    self.imgSetting2.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
                }, completion: nil)
            })
        }
    }
}
