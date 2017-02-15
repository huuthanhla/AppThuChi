//
//  BaseScrollView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/16/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import UIKit

class BaseScrollView: UIScrollView {
    
    var bottomConstraint:NSLayoutConstraint!
    
    let viewSuper:UIView =
        {
            let view:UIView = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp()
    {
        self.addSubview(viewSuper)
        viewSuper.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bottomConstraint =  viewSuper.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        bottomConstraint.isActive = true
        viewSuper.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        viewSuper.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
