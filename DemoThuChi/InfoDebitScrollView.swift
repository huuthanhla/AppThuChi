//
//  InfoDebitScrollView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/20/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class InfoDebitScrollView:BaseScrollView
{
    var arrDebtor:Array<Debtor> = Array<Debtor>()
    var y:CGFloat = 0
    var centerYConstraint:NSLayoutConstraint!
    var currentDebtor:Debtor!
    
    let viewInfo:InfoDebtorView =
        {
            let view:InfoDebtorView = InfoDebtorView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
    let btnSearch:UIButton =
        {
            let btn:UIButton = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setUp()
            btn.setTitle("Tìm", for: UIControlState.normal)
            return btn
    }()
    
    let viewSearchDebtor:SearchDebtorView =
    {
        let view:SearchDebtorView = SearchDebtorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func setUp() {
        super.setUp()
        setUpViewInfo()
        setUpBtnSearch()
        setUpViewSearch()
        setUpTxtDelegate()
        setUpNotification()
        loadData()
    }
    
    func loadData()
    {
        readData(node: "Debtor") { (dic) in
            self.arrDebtor.removeAll()
            for i in dic
            {
                let deb = Debtor(data: i.value as! Dictionary<String, Any>)
                self.arrDebtor.append(deb)
                self.viewSearchDebtor.tblListDebtor.reloadData()
            }

        }
    }
    
    func setUpViewInfo()
    {
        self.addSubview(viewInfo)
        viewInfo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewInfo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        viewInfo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 7/8).isActive = true
        viewInfo.imgAvatar.layer.cornerRadius = 10
        viewInfo.layer.cornerRadius = 10
        viewInfo.btnAdd.addTarget(self, action: #selector(InfoDebitScrollView.tapBtnAdd), for: UIControlEvents.touchUpInside)
    }
    
    func tapBtnAdd()
    {
        if currentDebtor != nil
        {
            for i in self.viewInfo.arrTxt
            {
                i.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0).cgColor
            }
            if self.viewInfo.validTxt().count == 0
            {
                let alert:ViewAlertAlert = ViewAlertAlert()
                alert.show(view: self)
                currentDebtor.numberDebit += 1
                AddDebit(idDebtor: currentDebtor.id, name: "\(currentDebtor.numberDebit)", money: Int(viewInfo.txtMoney.text!)!, periMoney: Int(viewInfo.txtPeriMoney.text!)!, cycle: Int(viewInfo.txtCycle.text!)!, cat: viewInfo.segmentChoose.selectedSegmentIndex, alert: nil)
                upDateData(node: "Debtor/\(currentDebtor.id)/numberDebit", value: currentDebtor.numberDebit, alert: alert, completion: {
                    viewInfo.setValue(img: nil, name: currentDebtor.name, identity: currentDebtor.identity, address: currentDebtor.address, phone: currentDebtor.phone, nameDebit: String(currentDebtor.numberDebit + 1))
                })
            }
            else
            {
                for i in self.viewInfo.validTxt()
                {
                    for j in self.viewInfo.arrTxt
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
        else
        {
            self.tapBackground()
        }
        
    }
    
    func setUpViewSearch()
    {
        self.addSubview(viewSearchDebtor)
        viewSearchDebtor.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
       centerYConstraint = viewSearchDebtor.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        centerYConstraint.isActive = true
        viewSearchDebtor.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        viewSearchDebtor.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        viewSearchDebtor.alpha = 1
        
        viewSearchDebtor.tblListDebtor.dataSource = self
        viewSearchDebtor.tblListDebtor.delegate = self
    }
    
    func setUpBtnSearch()
    {
        self.addSubview(btnSearch)
        btnSearch.trailingAnchor.constraint(equalTo: viewInfo.trailingAnchor).isActive = true
        btnSearch.bottomAnchor.constraint(equalTo: viewInfo.topAnchor, constant: -20).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnSearch.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        btnSearch.addTarget(self, action: #selector(InfoDebitScrollView.tapBackground), for: UIControlEvents.touchUpInside)
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InfoDebitScrollView.tapBackground))
        viewSearchDebtor.viewBackground.addGestureRecognizer(tapGesture)
    }
    
    func tapBackground()
    {
        if self.centerYConstraint.constant != 0
        {
            self.centerYConstraint.constant = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.viewSearchDebtor.alpha = 1
                self.layoutSubviews()
            })
        }
        else
        {
            self.centerYConstraint.constant = self.frame.height
            UIView.animate(withDuration: 0.4) {
                self.viewSearchDebtor.alpha = 0
                self.layoutSubviews()
            }
        }
    }
    
    
    func setUpTxtDelegate()
    {
        for i in viewInfo.arrTxt
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

extension InfoDebitScrollView:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.y = viewInfo.frame.origin.y + textField.frame.origin.y + 30
    }
}

extension InfoDebitScrollView:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDebtor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblListDebtorCell", for: indexPath) as! tblListDebtorCell
        cell.imgAvatar.layer.cornerRadius = 10
        cell.imgAvatar.loadImage(link: arrDebtor[indexPath.row].avatar)
        cell.lblName.text = arrDebtor[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Chọn Tên Người Nợ"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let debtor:Debtor = arrDebtor[indexPath.row]
        self.viewInfo.setValue(img: debtor.avatar,name: debtor.name, identity: debtor.identity, address: debtor.address, phone: debtor.phone, nameDebit: String(debtor.numberDebit + 1))
        self.currentDebtor = arrDebtor[indexPath.row]
        self.tapBackground()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 6
    }
}
