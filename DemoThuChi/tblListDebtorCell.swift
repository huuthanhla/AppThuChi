//
//  tblListDebtorCell.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/13/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import UIKit

class tblListDebtorCell: UITableViewCell {

    let imgAvatar:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFit
            img.clipsToBounds = true
            img.image = #imageLiteral(resourceName: "avatar")
            return img
    }()
    
    let lblName:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "Tên người nợ", txtColor: UIColor.black, fontSize: 18, cornerRadius: nil, textAlignment: .left)
            return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpImg()
        setUpLblName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpImg()
    {
        self.addSubview(imgAvatar)
        imgAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        imgAvatar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        imgAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        imgAvatar.widthAnchor.constraint(equalTo: imgAvatar.heightAnchor).isActive = true
    }
    
    func setUpLblName()
    {
        self.addSubview(lblName)
        lblName.topAnchor.constraint(equalTo: imgAvatar.topAnchor).isActive = true
        lblName.bottomAnchor.constraint(equalTo: imgAvatar.bottomAnchor).isActive = true
        lblName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        lblName.leadingAnchor.constraint(equalTo: imgAvatar.trailingAnchor, constant: 5).isActive = true
    }

}
