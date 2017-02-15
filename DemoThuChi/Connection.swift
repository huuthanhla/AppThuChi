//
//  Connection.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/13/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var currentUser:User = User()

let ref:FIRDatabaseReference = FIRDatabase.database().reference()

func login(email: String, password:String, completion: @escaping (Bool)->(), alert:ViewAlertAlert?)
{
    FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
        if error == nil
        {
            currentUser = User(data: user)
            completion(true)
            alert?.stopAnimation(stt: true)
        }
        else
        {
            completion(false)
            alert?.stopAnimation(stt: false)
        }
    }
}

func updateAvatar(image:UIImage, alert:ViewAlertAlert)
{
    let data:Data = UIImageJPEGRepresentation(image, 0.1)!
    upLoadImage(imgData: data, idDebtor: "avatarUser/\(currentUser.email)", completion: { (url) in
        if url != nil
        {
            let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
            changeRequest?.photoURL = url!
            changeRequest?.commitChanges() { (error) in
                if error == nil
                {
                    alert.stopAnimation(stt: true)
                }
                else
                {
                    alert.stopAnimation(stt: false)
 
                }
            }
            
        }
        else
        {
            alert.stopAnimation(stt: false)
        }
    })

}


func register(email:String, password:String, fullName:String, avatar:UIImage, alert:ViewAlertAlert?)
{
    let dataAvatar:Data = UIImageJPEGRepresentation(avatar, 0.5)!
    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
        if error == nil
        {
            upLoadImage(imgData: dataAvatar, idDebtor: "avatarUser/\(user!.email!)", completion: { (url) in
                if url != nil
                {
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                    changeRequest?.displayName = fullName
                    changeRequest?.photoURL = url!
                    changeRequest?.commitChanges() { (error) in
                        if error == nil
                        {
                            alert?.stopAnimation(stt: true)
                        }
                        else
                        {
                            alert?.stopAnimation(stt: false)
                        }
                    }
                }
                else
                {
                    user?.delete { error in
                        
                        
                    }
                    
                    alert?.stopAnimation(stt: false)
                }
                
            })
            
            
        }
        else
        {
            alert?.stopAnimation(stt: false)
        }
    }
    
}

func getCurrentUser(completion:(Bool)->())
{
    if FIRAuth.auth()?.currentUser != nil {
        let u = FIRAuth.auth()?.currentUser
        currentUser = User(data: u)
        completion(true)
    } else {
        completion(false)
    }
}

func logOut(alert:ViewAlertAlert?)
{
    do {
        
        try FIRAuth.auth()?.signOut()
        alert?.stopAnimation(stt: true)
        
    } catch _ as NSError {
        alert?.stopAnimation(stt: false)
    }
    
}

func changePassword(pass:String, alert:ViewAlertAlert, completion:@escaping (Error?)->())
{
    FIRAuth.auth()?.currentUser?.updatePassword(pass) { (error) in
        
        if error == nil
        {
            alert.stopAnimation(stt: true)
        }
        else
        {
            alert.stopAnimation(stt: false)
            print("-----------------",error!)
        }
        completion(error)
    
    }
}


func writeData(node:String, data:inout Dictionary<String, Any>, alert:ViewAlertAlert?)->String
{
    let dataref = ref.child(currentUser.id).child(node).childByAutoId()
    data["id"] = String(dataref.key)
    dataref.setValue(data)
    if alert != nil
    {
        alert?.stopAnimation(stt: true)
    }
    
    return String(dataref.key)
}

func readData(node:String, completion: @escaping (Dictionary<String,Any>)->())
{
    let postRef = ref.child(currentUser.id).child(node)
    postRef.observe(FIRDataEventType.value, with: { (snapshot) in
        if let postDict = snapshot.value as? Dictionary<String, Any>
        {
            completion(postDict)
        }
    })
}

func readDataSortBy(node:String, key:String ,value:Any,completion: @escaping (Dictionary<String, Any>)->())
{
    let postRef = ref.child(currentUser.id).child(node)
    let query = postRef.queryOrdered(byChild: key).queryEqual(toValue: value)
    query.observe(FIRDataEventType.value, with: { (snapshot) in
        if let postDict = snapshot.value as? Dictionary<String, Any>
        {
            completion(postDict)
        }
        
    })
}

func readDataSortBys(node:String, key:String ,value:Any,completion: @escaping (Dictionary<String, Any>)->())
{
    let postRef = ref.child(currentUser.id).child(node)
    let query = postRef.queryOrdered(byChild: key).queryEqual(toValue: value)
    
    query.observeSingleEvent(of: .value, with: { (snapshot) in
        if let postDict = snapshot.value as? Dictionary<String, Any>
        {
            completion(postDict)
        }
    }) { (error) in
        print(error.localizedDescription)
    }
}

func upDateData(node:String, value:Any, alert:ViewAlertAlert?, completion: ()->())
{
    let dataref = ref.child(currentUser.id).child(node)
    dataref.setValue(value)
    if alert != nil
    {
        alert?.stopAnimation(stt: true)
    }
    
    completion()
}

func AddDebtor(name:String, identity:String, phone:String, address:String, avatar:String, money:Int, periMoney:Int, cycle:Int, cat:Int, alert:ViewAlertAlert?)
{
    
    
    var deb:Dictionary<String,Any> = ["id":0,"name":name, "identity": identity, "phone":phone, "address":address, "avatar":avatar, "numberDebit":1]
    
    let idDebtor:String = writeData(node: "Debtor", data: &deb, alert: nil)
    
    AddDebit(idDebtor: idDebtor, name: "1", money: money, periMoney: periMoney, cycle: cycle,cat: cat,alert: alert)
}

func AddDebit(idDebtor:String,name:String ,money:Int ,periMoney:Int, cycle:Int, cat:Int ,alert:ViewAlertAlert?)
{
    let currentDate:String = getCurrentDate()
    var dic:Dictionary<String, Any> = ["id":0,"name":name , "debtorId":idDebtor, "money":money,"periMoney":periMoney, "date": currentDate, "cycle": cycle, "cat":cat, "debited": 0]
    let idDebit:String = writeData(node: "Debit", data: &dic, alert: nil)
    if cat == 0
    {
        ProcessDebit(idDebtor: idDebtor, idDebit: idDebit, money: money, periMoney: periMoney, cycle: cycle ,alert: alert)
    }
    else
    {
        ProcessInterestRate(idDebtor: idDebtor, idDebit: idDebit, money: money, periMoney: periMoney, cycle: cycle, debited: 0,alert: alert)
    }
    
    
}

func ProcessInterestRate(idDebtor:String, idDebit:String, money:Int, periMoney:Int, cycle:Int, debited:Int ,alert:ViewAlertAlert?)
{
    var dic:Dictionary<String,Any> = ["id":0,"debtorId": idDebtor,"debitId":idDebit, "periMoney":money * periMoney / 100 + debited, "stt":0, "date": getNextDate(i: cycle)]
    let _ = writeData(node: "ListDateDebit", data: &dic, alert: alert)
}

func ProcessInterestRates(idDebtor:String, idDebit:String, money:Int, periMoney:Int, cycle:Int, debited:Int, date:String ,alert:ViewAlertAlert?)
{
    var dic:Dictionary<String,Any> = ["id":0,"debtorId": idDebtor,"debitId":idDebit, "periMoney":money * periMoney / 100 + debited, "stt":0, "date": getNextDateFromDate(date: date, i: cycle)]
    let _ = writeData(node: "ListDateDebit", data: &dic, alert: alert)
}

func ProcessDebit(idDebtor:String , idDebit:String, money:Int, periMoney:Int, cycle:Int, alert:ViewAlertAlert?)
{
    var numberOfDay:Int = 0
    var rest:Int = 0
    if money % periMoney == 0
    {
        numberOfDay = money / periMoney
    }
    else
    {
        numberOfDay = money / periMoney + 1
        rest = money % periMoney
    }
    
    for i in 0..<numberOfDay
    {
        var dic:Dictionary<String,Any> = ["id":0,"debtorId": idDebtor,"debitId":idDebit, "periMoney":periMoney, "stt":0, "date": getNextDate(i: cycle * (i + 1))]
        
        if i == numberOfDay - 1 && rest != 0
        {
            dic["periMoney"] = rest
        }
        if i == numberOfDay - 1
        {
            dic["stt"] = 4
        }
        
        let _ = writeData(node: "ListDateDebit", data: &dic, alert: alert)
    }
}

func getCurrentDate()->String
{
    let calendar = Calendar.current
    let m_day = calendar.component(Calendar.Component.day, from: Date())
    let day = valid(number: m_day)
    let m_month = calendar.component(Calendar.Component.month, from: Date())
    let month = valid(number: m_month)
    let m_year = calendar.component(Calendar.Component.year, from: Date())
    let year = valid(number: m_year)
    return "\(day)/\(month)/\(year)"
}

func valid(number:Int)->String
{
    if number < 10
    {
        return "0\(number)"
    }
    else
    {
        return "\(number)"
    }
}

func getNextDate(i:Int)->String
{
    let date:Date = Calendar.current.date(byAdding: Calendar.Component.day, value: i, to: Date())!
    let m_day = Calendar.current.component(Calendar.Component.day, from: date)
    let day = valid(number: m_day)
    let m_month = Calendar.current.component(Calendar.Component.month, from: date)
    let month = valid(number: m_month)
    let m_year = Calendar.current.component(Calendar.Component.year, from: date)
    let year = valid(number: m_year)
    return "\(day)/\(month)/\(year)"
}

func getNextDateFromDate(date:String, i:Int)->String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let m_date:Date = dateFormatter.date(from: date)!
    
    let date:Date = Calendar.current.date(byAdding: Calendar.Component.day, value: i, to: m_date)!
    let m_day = Calendar.current.component(Calendar.Component.day, from: date)
    let day = valid(number: m_day)
    let m_month = Calendar.current.component(Calendar.Component.month, from: date)
    let month = valid(number: m_month)
    let m_year = Calendar.current.component(Calendar.Component.year, from: date)
    let year = valid(number: m_year)
    return "\(day)/\(month)/\(year)"
}

func validDayToChange(date:String)->Bool
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    let m_date:Date = dateFormatter.date(from: date)!
    return m_date <= Date()
}


func upLoadImage(imgData:Data, idDebtor:String, completion:@escaping (URL?)->())
{
    let storage = FIRStorage.storage()
    let storageRef = storage.reference(forURL: "gs://ungdungthutien.appspot.com")
    
    let avatarRef = storageRef.child("avatar/\(idDebtor).jpg")
    
    let uploadTask = avatarRef.put(imgData, metadata: nil) { (metadata, error) in
        guard let metadata = metadata else {
            completion(nil)
            return
        }
        let downloadURL = metadata.downloadURL()
        completion(downloadURL)
    }
    uploadTask.resume()
}

func loadDataImg(link:String, completion:@escaping (UIImage)->())
{
    let url:URL = URL(string: link)!
    let queue = DispatchQueue(label: "loadDataImg")
    queue.async {
        do
        {
            let data:Data = try Data(contentsOf: url)
            DispatchQueue.main.async {
                let img = UIImage(data: data)!
                completion(img)
            }
            
        }
        catch
        {
        }
    }
}
