//
//  CalendarView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/21/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class CalendarView: BaseView {
    
    let picker:UIDatePicker =
        {
            let pic:UIDatePicker = UIDatePicker()
            pic.translatesAutoresizingMaskIntoConstraints = false
            pic.datePickerMode = .date
            pic.locale = Locale.current
            return pic
    }()
    
    let btnOk:UIButton =
        {
            let btn:UIButton = UIButton()
            btn.setUp()
            btn.setTitle("Chọn", for: UIControlState.normal)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
    }()
    
    override func setUp() {
        setUpbtnOk()
        setUpPicker()
    }
    
    func setUpbtnOk()
    {
        self.addSubview(btnOk)
        btnOk.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        btnOk.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        btnOk.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnOk.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func setUpPicker()
    {
        self.addSubview(picker)
        picker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        picker.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: btnOk.topAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
    }
}
