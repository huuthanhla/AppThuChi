//
//  AddDebtsCollectViewCell.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/18/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class  AddDebtsCollectViewCell: BaseCollectionViewCell {
    
    let scroll:InfoDebitScrollView =
        {
            let scr:InfoDebitScrollView = InfoDebitScrollView()
            scr.translatesAutoresizingMaskIntoConstraints = false
            return scr
    }()
       
    override func setUp() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpScroll()
        setUpView()
    }
    
    func setUpScroll()
    {
        self.addSubview(scroll)
        scroll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scroll.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scroll.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        scroll.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scroll.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scroll.centerYConstraint.constant = self.frame.height
    }
    
    func setUpView()
    {
        scroll.viewSuper.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        scroll.viewSuper.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
    }
}
