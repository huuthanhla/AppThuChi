//
//  BaseCollectionViewCell.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/15/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
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
