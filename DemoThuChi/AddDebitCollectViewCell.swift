//
//  AddDebitCollectViewCell.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/15/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import UIKit

class AddDebitCollectViewCell: BaseCollectionViewCell {
    
    let scroll:AddDebitScrollView =
        {
            let scr:AddDebitScrollView = AddDebitScrollView()
            scr.translatesAutoresizingMaskIntoConstraints = false
            return scr
    }()
    
    override func setUp() {
        setUpScroll()
        setUpView()
    }
    
    func setUpScroll()
    {
        scroll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(scroll)
        scroll.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scroll.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scroll.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setUpView()
    {
        scroll.viewSuper.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
         scroll.viewSuper.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        
    }
}
