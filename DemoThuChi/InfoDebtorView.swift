//
//  InfoDebtorView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/18/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class InfoDebtorView: BaseView {
    
    var arrTxt:Array<UITextField> = []
    
    let imgAvatar:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.clipsToBounds = true
            img.image = #imageLiteral(resourceName: "avatar")
            img.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return img
    }()
    
    let lblName:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.adjustsFontSizeToFitWidth = true
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "Họ và tên: ", txtColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), fontSize: 16, cornerRadius: 4, textAlignment: .left)
            lbl.font = lbl.font.withTraits(traits: .traitBold)
            return lbl
    }()
    
    let lblContact:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.adjustsFontSizeToFitWidth = true
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "CMND: \nĐịa chỉ: \nSĐT: ", txtColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), fontSize: 16, cornerRadius: 4, textAlignment: .left)
            return lbl
    }()
    
    let line:UIView =
        {
            let view:UIView = UIView()
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
    let lblTitle:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "Thêm khoản nợ", txtColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), fontSize: 18, cornerRadius: nil, textAlignment: .left)
            
            lbl.font = lbl.font.withTraits(traits: .traitBold, .traitItalic)
            return lbl
    }()
    
    let segmentChoose:UISegmentedControl =
        {
            let segment:UISegmentedControl = UISegmentedControl()
            segment.translatesAutoresizingMaskIntoConstraints = false
            segment.insertSegment(withTitle: "Thường", at: 0, animated: true)
            segment.insertSegment(withTitle: "Lãi suất", at: 1, animated: true)
            segment.selectedSegmentIndex = 0
            segment.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            segment.setTitleTextAttributes([NSForegroundColorAttributeName : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: UIControlState.selected)
            return segment
    }()
    
    let lblNumOfDebts:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "Khoản nợ số ", txtColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), fontSize: 16, cornerRadius: nil, textAlignment: NSTextAlignment.left)
            return lbl
        }()
    
    let txtMoney:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 0
            return txt
    }()
    
    let txtPeriMoney:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 1
            return txt
    }()
    
    let txtCycle:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 2
            return txt
    }()

    
    let btnAdd:UIButton =
        {
            let btn:UIButton = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Thêm", for: UIControlState.normal)
            btn.setUp()
            return btn
    }()
    
    override func setUp() {
        self.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.7613929296, blue: 0.7201619339, alpha: 1)
        setUpImgAvatar()
        setUpLbl()
        setUpLine()
        setUplblTitle()
        setUpSegmentChoose()
        setUpTxt()
        setUpBtnAdd()
    }
    
    func setValue(img:String? ,name:String, identity:String, address:String, phone:String, nameDebit:String)
    {
        if img != nil
        {
            imgAvatar.loadImage(link: img!)
        }
        lblName.text = "Họ và tên: \(name)"
        lblContact.text = "CMND: \(identity)\nĐịa chỉ: \(address)\nSĐT: \(phone)"
        lblNumOfDebts.text = "Khoảng nợ số \(nameDebit)"
        txtMoney.text = ""
        txtPeriMoney.text = ""
        txtCycle.text = ""
    }
    
    func setUpImgAvatar()
    {
        self.addSubview(imgAvatar)
        imgAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        imgAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imgAvatar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        imgAvatar.heightAnchor.constraint(equalTo: imgAvatar.widthAnchor).isActive = true
    }
    
    func setUpLbl()
    {
        self.addSubview(lblName)
        lblName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        lblName.topAnchor.constraint(equalTo: imgAvatar.topAnchor).isActive = true
        lblName.leadingAnchor.constraint(equalTo: imgAvatar.trailingAnchor, constant: 10).isActive = true
        lblName.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        lblName.heightAnchor.constraint(lessThanOrEqualTo: imgAvatar.widthAnchor, multiplier: 1/2).isActive = true
        
        self.addSubview(lblContact)
        lblContact.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 0).isActive = true
        lblContact.leadingAnchor.constraint(equalTo: lblName.leadingAnchor).isActive = true
        lblContact.trailingAnchor.constraint(equalTo: lblName.trailingAnchor).isActive = true
        lblContact.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
        lblContact.bottomAnchor.constraint(lessThanOrEqualTo: imgAvatar.bottomAnchor).isActive = true
    }
    
    func setUpLine()
    {
        self.addSubview(line)
        line.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant: 5).isActive = true
        line.heightAnchor.constraint(equalToConstant: 5).isActive = true
        line.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        line.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func setUplblTitle()
    {
        self.addSubview(lblTitle)
        lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblTitle.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 5).isActive = true
        lblTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.addSubview(lblNumOfDebts)
        lblNumOfDebts.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 5).isActive = true
        lblNumOfDebts.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor).isActive = true
        lblNumOfDebts.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor).isActive = true
        lblNumOfDebts.heightAnchor.constraint(equalTo: lblTitle.heightAnchor).isActive = true
    }
    
    func setUpSegmentChoose()
    {
        self.addSubview(segmentChoose)
        segmentChoose.topAnchor.constraint(equalTo: lblTitle.topAnchor).isActive = true
        segmentChoose.bottomAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        segmentChoose.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        segmentChoose.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        segmentChoose.addTarget(self, action: #selector(InfoDebtorView.tapSegment), for: UIControlEvents.valueChanged)
    }
    
    func setUpTxt()
    {
        self.addSubview(txtMoney)
        txtMoney.topAnchor.constraint(equalTo: lblNumOfDebts.bottomAnchor, constant: 10).isActive = true
        txtMoney.leadingAnchor.constraint(equalTo: lblNumOfDebts.leadingAnchor).isActive = true
        txtMoney.trailingAnchor.constraint(equalTo: lblNumOfDebts.trailingAnchor).isActive = true
        txtMoney.heightAnchor.constraint(equalToConstant: 30).isActive = true
        txtMoney.placeholder = "💵 Số tiền vay"
        txtMoney.keyboardType = .numberPad
        txtMoney.addDoneButtonOnKeyboard()
        arrTxt = [txtMoney, txtPeriMoney, txtCycle]
        let arrPlace:Array<String> = ["💵 Số tiền vay", "💸 Tiền thanh toán định kỳ", "♼ Chu kỳ"]
        let arrKeyType:Array<UIKeyboardType> = [UIKeyboardType.numberPad, UIKeyboardType.numberPad, UIKeyboardType.numberPad]
        
        for i in 1..<arrTxt.count
        {
            self.addSubview(arrTxt[i])
            arrTxt[i].topAnchor.constraint(equalTo: arrTxt[i-1].bottomAnchor, constant: 15).isActive = true
            arrTxt[i].leadingAnchor.constraint(equalTo: arrTxt[i-1].leadingAnchor).isActive = true
            arrTxt[i].trailingAnchor.constraint(equalTo: arrTxt[i-1].trailingAnchor).isActive = true
            arrTxt[i].heightAnchor.constraint(equalToConstant: 30).isActive = true
            arrTxt[i].placeholder = arrPlace[i]
            arrTxt[i].keyboardType = arrKeyType[i]
            if arrKeyType[i] == .numberPad
            {
                arrTxt[i].addDoneButtonOnKeyboard()
            }
        }
    }
    
    func setUpBtnAdd()
    {
        self.addSubview(btnAdd)
        btnAdd.centerXAnchor.constraint(equalTo: txtCycle.centerXAnchor).isActive = true
        btnAdd.widthAnchor.constraint(equalTo: txtCycle.widthAnchor, multiplier: 1/2).isActive = true
        btnAdd.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnAdd.topAnchor.constraint(equalTo: txtCycle.bottomAnchor, constant: 10).isActive = true
        btnAdd.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    func tapSegment()
    {
        if segmentChoose.selectedSegmentIndex == 0
        {
            txtPeriMoney.placeholder = "💸 Tiền thanh toán định kỳ"
        }
        else
        {
            txtPeriMoney.placeholder = "💸 Lãi suất(%)"
        }
    }

    
    func validTxt()->Array<Int>
    {
        var arr:Array<Int> = Array<Int>()
        if !txtMoney.validNumber()
        {
            arr.append(txtMoney.tag)
        }
        if !txtPeriMoney.validNumber()
        {
            arr.append(txtPeriMoney.tag)
        }
        
        if !txtCycle.validNumber()
        {
            arr.append(txtCycle.tag)
        }
        
        if txtCycle.validNumber()
        {
            if Int(txtCycle.text!)! <= 0
            {
                arr.append(txtCycle.tag)
            }
        }
        
        if txtMoney.validNumber() && txtPeriMoney.validNumber()
        {
            if Int(txtPeriMoney.text!)! > Int(txtMoney.text!)!
            {
                arr.append(txtMoney.tag)
                arr.append(txtPeriMoney.tag)
            }
        }
        
        return arr
    }
}

