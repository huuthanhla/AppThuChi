//
//  SearchDebtorView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/20/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class SearchDebtorView: BaseView {
    
    let viewBackground:UIView =
        {
            let view:UIView = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            return view
    }()
    
    let tblListDebtor:UITableView =
        {
            let tbl:UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
            tbl.translatesAutoresizingMaskIntoConstraints = false
            tbl.register(tblListDebtorCell.self, forCellReuseIdentifier: "tblListDebtorCell")
            return tbl
    }()
    
    override func setUp() {
        self.backgroundColor = UIColor.clear
        setUpViewBackground()
        setUpTbl()
    }
    
    func setUpViewBackground()
    {
        self.addSubview(viewBackground)
        viewBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewBackground.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewBackground.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        viewBackground.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    func setUpTbl()
    {
        self.addSubview(tblListDebtor)
        tblListDebtor.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tblListDebtor.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tblListDebtor.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true
        tblListDebtor.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    
}
