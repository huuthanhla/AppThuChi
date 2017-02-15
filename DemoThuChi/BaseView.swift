//
//  BaseView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/14/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp()
    {
    }
}
