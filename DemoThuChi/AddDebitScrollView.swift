//
//  AddDebitScrollView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/16/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class AddDebitScrollView: BaseScrollView {
    
    var y:CGFloat = 0
    
    let regisView:RegistAddDebitView =
        {
            let view:RegistAddDebitView = RegistAddDebitView()
            return view
    }()
    
    override func setUp() {
        super.setUp()
        self.viewSuper.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpRegisView()
        setUpTxtDelegate()
        setUpNotification()
    }
    
    func setUpRegisView()
    {
        self.viewSuper.addSubview(regisView)
        regisView.centerXAnchor.constraint(equalTo: self.viewSuper.centerXAnchor).isActive = true
        regisView.centerYAnchor.constraint(equalTo: self.viewSuper.centerYAnchor).isActive = true
        regisView.widthAnchor.constraint(equalTo: self.viewSuper.widthAnchor, multiplier: 7/8).isActive = true
        regisView.layer.cornerRadius = 10
        regisView.btnAdd.addTarget(self, action: #selector(self.tapBtnAdd), for: UIControlEvents.touchUpInside)
    }
    
    func tapBtnAdd()
    {
        for i in self.regisView.arrTxt
        {
            i.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0).cgColor
        }

        if self.regisView.validTxt().count == 0
        {
            let alert:ViewAlertAlert = ViewAlertAlert()
            alert.show(view: self)
            let data = UIImageJPEGRepresentation(regisView.imgAvatar.image!, 0.5)
            upLoadImage(imgData: data!, idDebtor: regisView.txtIdentity.text!) { (url) in
                if url != nil
                {
                    AddDebtor(name: self.regisView.txtName.text!, identity: self.regisView.txtIdentity.text!, phone: self.regisView.txtPhoneNumber.text!, address: self.regisView.txtAddress.text!, avatar: "\(url!)", money: Int(self.regisView.txtMoney.text!)!, periMoney: Int(self.regisView.txtPeriMoney.text!)!, cycle: Int(self.regisView.txtCycle.text!)!, cat: self.regisView.segmentChoose.selectedSegmentIndex, alert: alert)
                    self.regisView.reset()
                }
                else
                {
                    alert.stopAnimation(stt: false)
                }
            }
        }
        else
        {
            for i in self.regisView.validTxt()
            {
                for j in self.regisView.arrTxt
                {
                    if i == j.tag
                    {
                        j.layer.borderWidth = 2
                        j.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
                        j.layer.cornerRadius = 5
                    }
                }
            }
        }
    }
    
    
    func setUpTxtDelegate()
    {
        for i in regisView.arrTxt
        {
            i.delegate = self
        }
    }
    
    func setUpNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(AddDebitScrollView.showKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddDebitScrollView.hideKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func showKeyboard(_ notification:Notification)
    {
        let keyBoard = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let sizeKeyboard = keyBoard.cgRectValue
        let heightKeyboard = sizeKeyboard.height
        
        let distance = self.frame.height - (y + heightKeyboard)
        
        if distance < 0
        {
            let theRest = distance * -1 + 10
            bottomConstraint.constant = -theRest
            let Point:CGPoint = CGPoint(x: 0, y: theRest)
            self.setContentOffset(Point, animated: true)
        }
        
    }
    
    func hideKeyboard(_ notification:Notification)
    {
        self.bottomConstraint.constant = 0
        UIView.animate(withDuration: 1) {
            self.layoutSubviews()
        }
        
    }
}

extension AddDebitScrollView:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.y = regisView.frame.origin.y + textField.frame.origin.y + 30
    }
}
