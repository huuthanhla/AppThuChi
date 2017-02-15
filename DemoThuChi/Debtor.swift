//
//  Debtor.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/13/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Debtor {
    var id:String
    var name:String
    var identity:String
    var phone:String
    var address:String
    var avatar:String
    var numberDebit:Int
    init(data:Dictionary<String, Any>) {
        id = data["id"] as! String
        name = data["name"] as! String
        identity = data["identity"] as! String
        phone = data["phone"] as! String
        address = data["address"] as! String
        avatar = data["avatar"] as! String
        numberDebit = data["numberDebit"] as! Int
    }
}


struct Debit {
    var id:String
    var name:String
    var money:Int
    var periMoney:Int
    var debtorId:String
    var date:String
    var cycle:Int
    var cat:Int
    var debited:Int
    var listDateDebit:Array<DateDebit>
    init(data:Dictionary<String, Any>) {
        id = data["id"] as! String
        name = data["name"] as! String
        money = data["money"] as! Int
        periMoney = data["periMoney"] as! Int
        debtorId = data["debtorId"] as! String
        date = data["date"] as! String
        cycle = data["cycle"] as! Int
        cat = data["cat"] as! Int
        debited = data["debited"] as! Int
        listDateDebit = Array<DateDebit>()
    }
}

struct DateDebit
{
    var id:String
    var debitId:String
    var debtorId:String
    var periMoney:Int
    var stt:Int
    var date:String
    init(data:Dictionary<String, Any>) {
        id = data["id"] as! String
        debitId = data["debitId"] as! String
        debtorId = data["debtorId"] as! String
        periMoney = data["periMoney"] as! Int
        date = data["date"] as! String
        stt = data["stt"] as! Int
    }
}

struct User {
    var id:String
    var email:String
    var fullName:String
    var avatar:UIImage?
    var urlAvatar:String
    init() {
        id = ""
        email = ""
        fullName = ""
        avatar = nil
        urlAvatar = ""
    }
    
    init(data:FIRUser?) {
        if let dataUser = data
        {
            id = dataUser.uid
            fullName = dataUser.displayName!
            email = dataUser.email!
            urlAvatar = String(describing: dataUser.photoURL!)
            avatar = nil
        }
        else
        {
            id = ""
            email = ""
            fullName = ""
            avatar = nil
            urlAvatar = ""
        }
    }
}
