//
//  ScrDetailDebit.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/21/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class ScrDetaildebit: BaseViewController {
    
    var debtor:Debtor!
    var date:String!
    var arrDebit:Array<Debit> = Array<Debit>()
    let lblName:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "Tên người nợ", txtColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), fontSize: 20, cornerRadius: nil, textAlignment: NSTextAlignment.center)
            lbl.font = lbl.font.withTraits(traits: .traitBold)
            lbl.numberOfLines = 0
            return lbl
    }()
    let lblSumDebit:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "Tổng nợ: ", txtColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), fontSize: 15, cornerRadius: nil, textAlignment: NSTextAlignment.left)
            lbl.numberOfLines = 0
            lbl.font = lbl.font.withTraits(traits: .traitBold)
            lbl.adjustsFontSizeToFitWidth = true
            return lbl
    }()
    let imgAvatar:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFill
            img.image = #imageLiteral(resourceName: "avatar")
            img.clipsToBounds = true
            return img
    }()
    
    lazy var tblListDebit:UITableView =
        {
            let tbl:UITableView = UITableView()
            tbl.translatesAutoresizingMaskIntoConstraints = false
            tbl.register(tblListDebitCell.self, forCellReuseIdentifier: "tblListDebitCell")
            tbl.delegate = self
            tbl.dataSource = self
            tbl.estimatedRowHeight = 300
            tbl.rowHeight = UITableViewAutomaticDimension
            return tbl
    }()
    
    override func setUp() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpLblName()
        setUpImgAvatar()
        setUpLblSum()
        setUpTbl()
        setUpNavigationController()
        loadData {
            self.loadSumDebit { (sum) in
                var SumDebit:Int = sum
                let string1 = "Tổng nợ: \(sum) VNĐ"
                self.lblSumDebit.text = string1
                for i in self.arrDebit
                {
                    if i.cat == 0
                    {
                        self.loadPayed(id: i.id, completion: { (sum2) in
                            SumDebit -= sum2
                            self.lblSumDebit.text = "\(string1)\nChưa trả: \(SumDebit) VNĐ"
                        })
                    }else
                    {
                        if i.cat == 2
                        {
                            SumDebit -= i.money
                            self.lblSumDebit.text = "\(string1)\nChưa trả: \(SumDebit) VNĐ"
                        }
                    }
                }

            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        imgAvatar.layer.cornerRadius = imgAvatar.frame.width / 2
    }
    
    func setUpLblName()
    {
        view.addSubview(lblName)
        lblName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblName.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        lblName.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        lblName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblName.adjustsFontSizeToFitWidth = true
    }
    
    func setUpLblSum()
    {
        view.addSubview(lblSumDebit)
        lblSumDebit.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lblSumDebit.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 5).isActive = true
        lblSumDebit.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        lblSumDebit.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        lblSumDebit.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
    }
    
    func setUpImgAvatar()
    {
        view.addSubview(imgAvatar)
        imgAvatar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        imgAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        imgAvatar.trailingAnchor.constraint(equalTo: lblName.leadingAnchor, constant: -5).isActive = true
        imgAvatar.heightAnchor.constraint(equalTo: imgAvatar.widthAnchor).isActive = true
    }
    
    func setUpTbl()
    {
        view.addSubview(tblListDebit)
        tblListDebit.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant: 10).isActive = true
        tblListDebit.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tblListDebit.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5).isActive = true
        tblListDebit.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    func setUpNavigationController()
    {
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        navigationItem.title = "Chi Tiết"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSFontAttributeName:UIFont(name: "Times New Roman", size: 20)!]
    }
    
    func loadData(completion:@escaping ()->())
    {
        if debtor != nil
        {
            self.lblName.text = debtor.name
            self.imgAvatar.loadImage(link: debtor.avatar)
            
            readDataSortBy(node: "Debit", key: "debtorId", value: debtor.id, completion: { (data) in
                self.arrDebit.removeAll()
                for i in data
                {
                    let debit:Debit = Debit(data: i.value as! Dictionary<String, Any>)
                    self.arrDebit.append(debit)
                }
                
                readDataSortBy(node: "ListDateDebit", key: "date", value: self.date, completion: { (data) in
                    
                    for i in 0..<self.arrDebit.count
                    {
                        self.arrDebit[i].listDateDebit.removeAll()
                    }
                    
                    for i in data
                    {
                        let dateDebit:DateDebit = DateDebit(data: i.value as! Dictionary<String, Any>)
                        for j in 0..<self.arrDebit.count
                        {
                            if self.arrDebit[j].id == dateDebit.debitId
                            {
                                self.arrDebit[j].listDateDebit.append(dateDebit)
                            }
                        }
                    }
                    self.tblListDebit.reloadData()
                    completion()
                })
            })
        }
    }
    
    func loadSumDebit(completion:@escaping (Int)->())
    {
        var sum:Int = 0
        readDataSortBy(node: "Debit", key: "debtorId", value: debtor.id) { (data) in
            for i in data
            {
                let debit:Debit = Debit(data: i.value as! Dictionary<String, Any>)
                sum += debit.money
            }
            completion(sum)
        }
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
}
extension ScrDetaildebit: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrDebit.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDebit[section].listDateDebit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblListDebitCell", for: indexPath) as! tblListDebitCell
        cell.selectionStyle = .none
        
        cell.lblInformation.text = "Số tiền cần trả là: \(arrDebit[indexPath.section].listDateDebit[indexPath.row].periMoney) VNĐ"
        switch arrDebit[indexPath.section].listDateDebit[indexPath.row].stt {
        case 0:
            cell.lblStatus.text = "Chưa trả"
            cell.lblStatus.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            break
        case 1:
            cell.lblStatus.text = "Đã trả"
            cell.lblStatus.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            break
        case 4:
            cell.lblStatus.text = "Chưa trả"
            cell.lblStatus.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.lblInformation.text = "\(cell.lblInformation.text!) (Ngày cuối)"
            break
        default:
            cell.lblStatus.text = "Nợ"
            cell.lblStatus.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.3445170078, blue: 0.2248790479, alpha: 1)
        let lbl:UILabel = UILabel(frame: CGRect(x: 5, y: 0, width: view.frame.width/3 - 5, height: 45))
        let lbl2:UILabel = UILabel(frame: CGRect(x: view.frame.width/3, y: 0, width: view.frame.width * 2 / 3 - 5, height: 45))
        view.addSubview(lbl)
        view.addSubview(lbl2)
        let line:UIView = UIView(frame: CGRect(x: 0, y: 45, width: view.frame.width, height: 5))
        line.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(line)
        lbl.numberOfLines = 0
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl2.numberOfLines = 0
        lbl2.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lbl2.adjustsFontSizeToFitWidth = true
        lbl2.textAlignment = .right
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        if arrDebit[section].listDateDebit.count == 0
        {
            lbl.text = "Khoản nợ số \(arrDebit[section].name)"
        }
        else
        {
            lbl.text = "Khoản nợ số \(arrDebit[section].name)"
        }
        
        loadPayed(id: arrDebit[section].id) { (sum) in
            if self.arrDebit[section].cat == 0
            {
                lbl2.text = "Đã trả: \(sum) VNĐ"
            }
            else
            {
                lbl2.text = "Tiền lãi: \(sum) VNĐ"
            }
            
        }
        
        
        return view
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (arrDebit[indexPath.section].listDateDebit[indexPath.row].stt == 0 || arrDebit[indexPath.section].listDateDebit[indexPath.row].stt == 4) && validDayToChange(date: arrDebit[indexPath.section].listDateDebit[indexPath.row].date)
        {
            return true
        }
//        if (arrDebit[indexPath.section].listDateDebit[indexPath.row].stt == 0 || arrDebit[indexPath.section].listDateDebit[indexPath.row].stt == 4)
//        {
//            return true
//        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if arrDebit[indexPath.section].listDateDebit[indexPath.row].stt == 0
        {
            let btnPay:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Thu tiền") { (btn, index) in
                let alert:ViewAlertAlert = ViewAlertAlert()
                alert.show(view: self.view)
                
                upDateData(node: "Debit/\(self.arrDebit[indexPath.section].id)/debited", value: self.arrDebit[indexPath.section].debited + self.arrDebit[indexPath.section].listDateDebit[indexPath.row].periMoney, alert: nil, completion: { 
                    
                })
                
                upDateData(node: "ListDateDebit/\(self.arrDebit[indexPath.section].listDateDebit[indexPath.row].id)/stt", value: 1, alert: alert, completion: {
                    
                    if self.arrDebit[indexPath.section].cat == 1
                    {
                        ProcessInterestRates(idDebtor: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].debtorId, idDebit: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].debitId, money: self.arrDebit[indexPath.section].money, periMoney: self.arrDebit[indexPath.section].periMoney, cycle: self.arrDebit[indexPath.section].cycle, debited: 0, date: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].date, alert: nil)
                    }
                    
                })
            }
            
            let btnDebt:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Nợ") { (btn, index) in
                let alert:ViewAlertAlert = ViewAlertAlert()
                alert.show(view: self.view)
                
                upDateData(node: "ListDateDebit/\(self.arrDebit[indexPath.section].listDateDebit[indexPath.row].id)/stt", value: 2, alert: alert, completion: {
                })
                if self.arrDebit[indexPath.section].cat == 1
                {
                    ProcessInterestRates(idDebtor: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].debtorId, idDebit: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].debitId, money: self.arrDebit[indexPath.section].money, periMoney: self.arrDebit[indexPath.section].periMoney, cycle: self.arrDebit[indexPath.section].cycle, debited: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].periMoney, date: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].date, alert: nil)
                }else
                {
                    var nextDDB:DateDebit!
                    readDataSortBys(node: "ListDateDebit", key: "debitId", value: self.arrDebit[indexPath.section].id, completion: { (data) in
                        for i in data
                        {
                            let next = DateDebit(data: i.value as! Dictionary<String, Any>)
                            if next.date == getNextDateFromDate(date: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].date, i: self.arrDebit[indexPath.section].cycle)
                            {
                                nextDDB = next
                                if nextDDB != nil
                                {
                                    upDateData(node: "ListDateDebit/\(nextDDB.id)/periMoney", value: self.arrDebit[indexPath.section].listDateDebit[indexPath.row].periMoney + nextDDB.periMoney, alert: nil, completion: {
                                    })
                                }
                                
                                
                            }
                        }
                    })
                }
            }
            
            let btnPayAll:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Trả hết", handler: { (btn, index) in
                let alert:ViewAlertAlert = ViewAlertAlert()
                alert.show(view: self.view)
                upDateData(node: "ListDateDebit/\(self.arrDebit[indexPath.section].listDateDebit[indexPath.row].id)/stt", value: 1, alert: alert, completion: {
                    
                    
                })
                upDateData(node: "Debit/\(self.arrDebit[indexPath.section].id)/cat", value: 2, alert: nil, completion: { 
                    
                })
            })
            
            btnPay.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            btnDebt.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            btnPayAll.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            if arrDebit[indexPath.section].cat == 1
            {
                return [btnPay, btnDebt, btnPayAll]
 
            }
            else
            {
                return [btnPay, btnDebt]
            }
        }
        else
        {
            if arrDebit[indexPath.section].listDateDebit[indexPath.row].stt == 4
            {
                let btnPay:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "Thu tiền") { (btn, index) in
                    let alert:ViewAlertAlert = ViewAlertAlert()
                    alert.show(view: self.view)
                    upDateData(node: "ListDateDebit/\(self.arrDebit[indexPath.section].listDateDebit[indexPath.row].id)/stt", value: 1, alert: alert, completion: {
                        
                    })
                }
                btnPay.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                return [btnPay]
            }
            else
            {
                return nil
            }
        }
    }
}
