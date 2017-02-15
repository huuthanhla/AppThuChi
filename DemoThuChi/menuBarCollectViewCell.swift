//
//  abc.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/15/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit
class menuBarCollectViewCell:BaseCollectionViewCell
{
    let imgIcon:UIImageView = {
        let img:UIImageView = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        return img
    }()
    
    let viewSelect:UIView =
        {
            let view:UIView = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            view.alpha = 0
            return view
    }()
    
    override func setUp() {
        setUpViewSelect()
        setUpImgIcon()
    }
    
    func setUpImgIcon()
    {
        self.addSubview(imgIcon)
        imgIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        imgIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        imgIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgIcon.widthAnchor.constraint(equalTo: imgIcon.heightAnchor).isActive = true
        imgIcon.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    
    func setUpViewSelect()
    {
        self.addSubview(viewSelect)
        viewSelect.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewSelect.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewSelect.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        viewSelect.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    override var isSelected: Bool
        {
        didSet
        {
            if isSelected
            {
                viewSelect.alpha = 1
                imgIcon.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                viewSelect.alpha = 0
                imgIcon.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                
            }
        }
    }
}
