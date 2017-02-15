//
//  ScrDebit.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/13/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class ScrDebit: BaseViewController {
    
    var arrDebtor:Array<Debtor> = Array<Debtor>()
    var date = ""
    var rightConstraint:NSLayoutConstraint!
    let Windown = UIApplication.shared.keyWindow!
    
    let lblSumMoneyToDay:UILabel = {
        let lbl:UILabel = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setUpLblTitle(title: " Tổng thu trong ngày: 0 VNĐ ", txtColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fontSize: 20, cornerRadius: nil, textAlignment: NSTextAlignment.left)
        lbl.font = lbl.font.withTraits(traits: .traitBold)
        lbl.numberOfLines = 0
        lbl.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return lbl
    }()
    
    let lblSumMoneyDebit:UILabel = {
        let lbl:UILabel = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setUpLblTitle(title: "Tổng nợ còn lại: 0 VNĐ", txtColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), fontSize: 20, cornerRadius: nil, textAlignment: NSTextAlignment.left)
        lbl.font = lbl.font.withTraits(traits: .traitBold)
        lbl.numberOfLines = 0
        lbl.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        return lbl
    }()
    
    lazy var tblListDebtor:UITableView = {
        let tbl:UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.register(tblListDebtorCell.self, forCellReuseIdentifier: "CellListDebtor")
        tbl.delegate = self
        tbl.dataSource = self
        return tbl
    }()
    
    let viewAddDebit:AddDebitView =
        {
            let view:AddDebitView = AddDebitView()
            view.backgroundColor = UIColor.clear
            return view
    }()
    
    let viewAlert:AlertView =
        {
            let view:AlertView = AlertView()
            return view
    }()
    
    override func setUp() {
        self.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        setUpNaviController()
        self.automaticallyAdjustsScrollViewInsets = false
        setUpLblSumMoneyDebit()
        setUpLblSumMoneyToDay()
        setUpTableDebtor()
        setUpViewAddDebit()
        setUpAlertView()
        setUpNotification()
        loadData(date: getCurrentDate())
        loadAllSumDebit()
        let screenEdge:UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(ScrDebit.screenEdge(_:)))
        screenEdge.edges = .left
        self.view.addGestureRecognizer(screenEdge)
    }
    
    func setUpLblSumMoneyDebit()
    {
        view.addSubview(lblSumMoneyDebit)
        lblSumMoneyDebit.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        lblSumMoneyDebit.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        lblSumMoneyDebit.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        lblSumMoneyDebit.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 1).isActive = true
        lblSumMoneyDebit.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    func setUpLblSumMoneyToDay()
    {
        view.addSubview(lblSumMoneyToDay)
        lblSumMoneyToDay.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        lblSumMoneyToDay.bottomAnchor.constraint(equalTo: self.lblSumMoneyDebit.topAnchor).isActive = true
        lblSumMoneyToDay.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        lblSumMoneyToDay.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 1).isActive = true
        lblSumMoneyToDay.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
    }
    
    func setUpTableDebtor()
    {
        view.addSubview(tblListDebtor)
        tblListDebtor.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tblListDebtor.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        tblListDebtor.bottomAnchor.constraint(equalTo: lblSumMoneyToDay.topAnchor).isActive = true
        tblListDebtor.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setUpNaviController()
    {
        let img:UIImage = #imageLiteral(resourceName: "Calendar")
        let btnCalendar:UIBarButtonItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ScrDebit.btn_Calendar(_:)))
        navigationItem.rightBarButtonItem = btnCalendar
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = UIColor.red
        
        let btnAdd:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ScrDebit.btn_Add(_:)))
        
        navigationItem.leftBarButtonItem = btnAdd
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        navigationItem.title = "Thu Tiền"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSFontAttributeName:UIFont(name: "Times New Roman", size: 20)!]
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func setUpViewAddDebit()
    {
        view.addSubview(viewAddDebit)
        viewAddDebit.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        viewAddDebit.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor).isActive = true
        viewAddDebit.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        rightConstraint = viewAddDebit.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        rightConstraint.isActive = true
        
        let tapBackground:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ScrDebit.btn_Add(_:)))
        viewAddDebit.viewTapHide.addGestureRecognizer(tapBackground)
    }
    
    func setUpAlertView()
    {
        self.Windown.addSubview(viewAlert)
        viewAlert.centerXAnchor.constraint(equalTo: self.Windown.centerXAnchor).isActive = true
        viewAlert.centerYAnchor.constraint(equalTo: self.Windown.centerYAnchor).isActive = true
        viewAlert.widthAnchor.constraint(equalTo: self.Windown.widthAnchor).isActive = true
        viewAlert.heightAnchor.constraint(equalTo: self.Windown.heightAnchor).isActive = true
        viewAlert.alpha = 0
        viewAlert.viewAlert.btnOk.addTarget(self, action: #selector(ScrDebit.chooseDateDebit), for: UIControlEvents.touchUpInside)
        
    }
    
    func chooseDateDebit()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.string(from: viewAlert.viewAlert.picker.date)
        loadData(date: strDate)
        
    }
    
    func setUpNotification()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ScrDebit.showAlert(_:)), name: NSNotification.Name.init("showAlert"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ScrDebit.showPicker(_:)), name: NSNotification.Name.init(rawValue: "showPicker"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ScrDebit.hide(_:)), name: NSNotification.Name.init(rawValue: "dismiss"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ScrDebit.showError(_:)), name: NSNotification.Name.init(rawValue: "error"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ScrDebit.goToLoginForm), name: NSNotification.Name.init("LogOut"), object: nil)
    }
    
    func btn_Calendar(_ sender:Any)
    {
        viewAlert.tapBackground()
    }
    
    func screenEdge(_ sender:Any)
    {
        if let ges = sender as? UIScreenEdgePanGestureRecognizer
        {
            if ges.state == .began
            {
                btn_Add(sender)
            }
        }
    }
    
    func btn_Add(_ sender:Any)
    {
        if rightConstraint.constant != 0
        {
            rightConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutSubviews()
            })
            self.view.endEditing(true)
        }
        else
        {
            rightConstraint.constant = viewAddDebit.frame.width - 1
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutSubviews()
            })
            
        }
        
    }
    
    func showAlert(_ noti:Notification)
    {
        if let alert:UIAlertController = noti.object as? UIAlertController
        {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showPicker(_ noti:Notification)
    {
        if let picker:UIImagePickerController = noti.object as? UIImagePickerController
        {
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func hide(_ noti:Notification)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func goToLoginForm()
    {
        let navi:UINavigationController = UINavigationController(rootViewController: ScrLogin())
        present(navi, animated: true, completion: nil)
    }
    
    func showError(_ noti:Notification)
    {
        var err:String = "Không xác định"
        if let stringErr:String = noti.object as? String
        {
            err = stringErr
        }
        let alert:UIAlertController = UIAlertController(title: "Lỗi", message: err, preferredStyle: UIAlertControllerStyle.alert)
        let btnOk:UIAlertAction = UIAlertAction(title: "Đồng Ý", style: .cancel, handler: nil)
        alert.addAction(btnOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func validInArr(arr:Array<Debtor>, value:Debtor)->Bool
    {
        for i in arr
        {
            if i.id == value.id
            {
                return false
            }
        }
        
        return true
    }
    
    func loadPayed(id:String, completion: @escaping (Int)->())
    {
        var sum:Int = 0
        readDataSortBy(node: "ListDateDebit", key: "debitId", value: id) { (data) in
            for i in data
            {
                let datedb:DateDebit = DateDebit(data: i.value as! Dictionary<String, Any>)
                if datedb.stt == 1
                {
                    sum += datedb.periMoney
                }
            }
            
            completion(sum)
        }
    }
    
    func loadAllSumDebit()
    {
        readData(node: "Debit") { (data) in
            var sumDebited:Int = 0
            var sum:Int = 0
            for i in data
            {
                let debit:Debit = Debit(data: i.value as! Dictionary<String, Any>)
                sum += debit.money
                if debit.cat == 0
                {
                    sumDebited += debit.debited
                }
                else
                {
                    if debit.cat == 2
                    {
                        sumDebited += debit.money
                    }
                }
            }
            self.lblSumMoneyDebit.text = "Tổng nợ còn lại: \(sum - sumDebited) VNĐ"
        }
    }
    
    func loadData(date:String){
        self.date = date
        self.arrDebtor.removeAll()
        self.tblListDebtor.reloadData()
        readDataSortBy(node: "ListDateDebit", key: "date", value: date) { (data) in
            self.arrDebtor.removeAll()
            var money:Int = 0
            self.lblSumMoneyToDay.text = " Tổng thu trong ngày: \(money) VNĐ "
            for i in data
            {
                let datedebit = DateDebit(data: i.value as! Dictionary<String, Any>)
                if datedebit.stt == 1
                    {
                        money += datedebit.periMoney
                        self.lblSumMoneyToDay.text = " Tổng thu trong ngày: \(money) VNĐ "
                }
                readDataSortBy(node: "Debtor", key: "id", value: datedebit.debtorId, completion: { (data) in
                    for i in data
                    {
                        let deb = Debtor(data: i.value as! Dictionary<String, Any>)
                        if self.validInArr(arr: self.arrDebtor, value: deb)
                        {
                            self.arrDebtor.append(deb)
                            self.tblListDebtor.reloadData()
                        }
                    }
                })
            }
        }
    }
}

extension ScrDebit:UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDebtor.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellListDebtor", for: indexPath) as! tblListDebtorCell
        cell.imgAvatar.layer.cornerRadius = 10
        cell.lblName.text = arrDebtor[indexPath.row].name
        cell.imgAvatar.loadImage(link: arrDebtor[indexPath.row].avatar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scr = ScrDetaildebit()
        scr.debtor = arrDebtor[indexPath.row]
        scr.date = self.date
        navigationController?.pushViewController(scr, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 7
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Danh sách thu trong ngày \(date)"
    }
}

