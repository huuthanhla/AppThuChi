//
//  AlertView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/14/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class AlertView: BaseView {
    
    var centerYConstraint:NSLayoutConstraint!
    
    let viewBackGround:UIView =
        {
            let view:UIView = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4320954623)
            return view
    }()
    
    let viewAlert:CalendarView =
        {
            let view:CalendarView = CalendarView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return view
    }()
    
    override func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        setUpViewBG()
        setUPViewAlert()
    }
    
    func setUpViewBG()
    {
        self.addSubview(viewBackGround)
        viewBackGround.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewBackGround.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewBackGround.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        viewBackGround.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AlertView.tapBackground))
        viewBackGround.addGestureRecognizer(tapGesture)
    }
    
    func setUPViewAlert()
    {
        self.addSubview(viewAlert)
        viewAlert.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        centerYConstraint = viewAlert.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: UIScreen.main.bounds.height)
        centerYConstraint.isActive = true
        viewAlert.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true
        viewAlert.heightAnchor.constraint(equalTo: viewAlert.widthAnchor).isActive = true
        
        viewAlert.btnOk.addTarget(self, action: #selector(AlertView.tapBtnOk), for: UIControlEvents.touchUpInside)
    }
    
    func tapBtnOk()
    {
        tapBackground()
    }
    
    func tapBackground()
    {
        if self.centerYConstraint.constant != 0
        {
            self.centerYConstraint.constant = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.alpha = 1
                self.layoutSubviews()
            })
        }
        else
        {
            self.centerYConstraint.constant = self.frame.height
            UIView.animate(withDuration: 0.4) {
                self.alpha = 0
                self.layoutSubviews()
            }
        }
    }
}
