//
//  AlertView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/22/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit


class ViewAlertAlert: BaseView {
    var timer:Timer!
    let backGroundView:UIView = {
        let view:UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        return view
    }()
    let imgLoading:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFit
            img.image = #imageLiteral(resourceName: "loading")
            return img
    }()
    override func setUp() {
        setUpBackGround()
        setUpImgLoading()
        self.alpha = 0
    }
    
    func setUpBackGround()
    {
        self.addSubview(backGroundView)
        backGroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        backGroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backGroundView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        backGroundView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    func setUpImgLoading()
    {
        self.addSubview(imgLoading)
        imgLoading.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgLoading.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgLoading.widthAnchor.constraint(equalTo: backGroundView.widthAnchor, multiplier: 1/4).isActive = true
        imgLoading.heightAnchor.constraint(equalTo: imgLoading.widthAnchor).isActive = true
    }
    
    func startAnimation()
    {
        var angel:Int = 0
        if self.timer == nil
        {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (timer) in
                if angel == 360
                {
                    angel = 0
                }
                angel += 5
                UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { 
                    self.imgLoading.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI)*CGFloat(angel)/180, 0, 0, 1)
                }, completion: nil)
            })
        }
    }
    
    func show(view:UIView)
    {
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            self.startAnimation()
        }
    }
    func stopAnimation(stt:Bool)
    {
        if timer != nil
        {
            self.timer.invalidate()
            self.timer = nil
            self.imgLoading.layer.transform = CATransform3DIdentity
        }
        UIView.animate(withDuration: 0.2) { 
            self.imgLoading.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        }
        imgLoading.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
        
       
        
        if stt
        {
            imgLoading.image = #imageLiteral(resourceName: "success")
        }
        else
        {
            imgLoading.image = #imageLiteral(resourceName: "error")
        }
        
       
        UIView.animate(withDuration: 0.5, animations: { 
            self.imgLoading.layer.transform = CATransform3DIdentity
        }) { (true) in
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (time) in
                UIView.animate(withDuration: 0.2, animations: { 
                    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
                    self.backGroundView.alpha = 0
                }, completion: { (true) in
                    self.removeFromSuperview()
                })
                
            })
        }
        
        
    }
}
