//
//  tblListDebitCell.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/21/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import UIKit

class tblListDebitCell: UITableViewCell {
    
    let lblInformation:UILabel = {
        let lbl:UILabel = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setUpLblTitle(title: "Số tiền cần trả:", txtColor: UIColor.black, fontSize: 18, cornerRadius: nil, textAlignment: NSTextAlignment.left)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lblStatus:UILabel = {
        let lbl:UILabel = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setUpLblTitle(title: "Trạng thái", txtColor: UIColor.white, fontSize: 16, cornerRadius: 5, textAlignment: NSTextAlignment.center)
        lbl.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        lbl.numberOfLines = 0
        return lbl
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp()
    {
        setUpLblInf()
        setUplblStt()
    }
    
    func setUpLblInf()
    {
        self.addSubview(lblInformation)
        lblInformation.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        lblInformation.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        lblInformation.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4).isActive = true
        lblInformation.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        lblInformation.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setUplblStt()
    {
        self.addSubview(lblStatus)
        lblStatus.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        lblStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        lblStatus.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        lblStatus.leftAnchor.constraint(equalTo: lblInformation.rightAnchor, constant: 5).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
