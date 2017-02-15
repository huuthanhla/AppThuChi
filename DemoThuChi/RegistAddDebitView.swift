//
//  RegistAddDebitView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/16/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class RegistAddDebitView:BaseView
{
    var arrTxt:Array<UITextField> = []
    
    let lblTitle:UILabel =
        {
            let lbl:UILabel = UILabel()
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.setUpLblTitle(title: "Thêm mới", txtColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), fontSize: 20, cornerRadius: nil, textAlignment: .left)
            lbl.font = lbl.font.withTraits(traits: .traitBold)
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
    
    let txtName:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 0
            txt.autocapitalizationType = .words
            return txt
    }()
    
    let txtIdentity:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 1
            return txt
    }()
    
    let txtPhoneNumber:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 2
            return txt
    }()
    
    let txtAddress:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 3
            return txt
    }()
    
    let txtMoney:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 4
            return txt
    }()
    
    let txtPeriMoney:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 5
            return txt
    }()
    
    let txtCycle:UITextField =
        {
            let txt:UITextField = UITextField()
            txt.translatesAutoresizingMaskIntoConstraints = false
            txt.setUp()
            txt.tag = 6
            return txt
    }()
    
    let imgAvatar:UIImageView =
        {
            let img:UIImageView = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.image = #imageLiteral(resourceName: "photo-camera")
            img.contentMode = .scaleAspectFit
            img.clipsToBounds = true
            return img
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
        backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.7613929296, blue: 0.7201619339, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        setUpLblTitle()
        setUpSegmentChoose()
        setUpTxt()
        setUpImgAvatar()
        setUpBtnAdd()
    }
    
    func setUpLblTitle()
    {
        self.addSubview(lblTitle)
        lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lblTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        lblTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setUpSegmentChoose()
    {
        self.addSubview(segmentChoose)
        segmentChoose.topAnchor.constraint(equalTo: lblTitle.topAnchor).isActive = true
        segmentChoose.bottomAnchor.constraint(equalTo: lblTitle.bottomAnchor).isActive = true
        segmentChoose.widthAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        segmentChoose.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        segmentChoose.addTarget(self, action: #selector(RegistAddDebitView.tapSegment), for: UIControlEvents.valueChanged)
    }
    
    func setUpTxt()
    {
        self.addSubview(txtName)
        txtName.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        txtName.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor).isActive = true
        txtName.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor).isActive = true
        txtName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        txtName.placeholder = "😀 Họ và tên"
        arrTxt = [txtName, txtIdentity, txtPhoneNumber, txtAddress, txtMoney, txtPeriMoney, txtCycle]
        let arrPlace:Array<String> = ["😀 Họ và tên", "🏠 Chứng mình nhân dân", "📞 Số điện thoại", "🏠 Địa chỉ", "💵 Số tiền vay", "💸 Tiền thanh toán định kỳ", "♼ Chu kỳ"]
        let arrKeyType:Array<UIKeyboardType> = [UIKeyboardType.default, UIKeyboardType.numberPad, UIKeyboardType.numberPad, UIKeyboardType.default, UIKeyboardType.numberPad, UIKeyboardType.numberPad, UIKeyboardType.numberPad]
        
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
    
    func setUpImgAvatar()
    {
        self.addSubview(imgAvatar)
        imgAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgAvatar.widthAnchor.constraint(equalTo: txtCycle.widthAnchor, multiplier: 1/2).isActive = true
        imgAvatar.topAnchor.constraint(equalTo: txtCycle.bottomAnchor, constant: 10).isActive = true
        imgAvatar.heightAnchor.constraint(equalTo: imgAvatar.widthAnchor).isActive = true
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegistAddDebitView.tapPhotoCamera))
        imgAvatar.addGestureRecognizer(tapGesture)
        imgAvatar.isUserInteractionEnabled = true
        
    }
    
    func setUpBtnAdd()
    {
        self.addSubview(btnAdd)
        btnAdd.centerXAnchor.constraint(equalTo: imgAvatar.centerXAnchor).isActive = true
        btnAdd.widthAnchor.constraint(equalTo: imgAvatar.widthAnchor).isActive = true
        btnAdd.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnAdd.topAnchor.constraint(equalTo: imgAvatar.bottomAnchor, constant: 10).isActive = true
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
    
    func tapPhotoCamera()
    {
        let picker:UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        
        let alert:UIAlertController = UIAlertController(title: "Vui lòng chọn", message: "Chọn ảnh đại diện", preferredStyle: UIAlertControllerStyle.alert)
        
        let btnCamera:UIAlertAction = UIAlertAction(title: "Máy Ảnh", style: UIAlertActionStyle.destructive) { (btn) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                picker.sourceType = .camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                picker.allowsEditing = true
                NotificationCenter.default.post(name: NSNotification.Name.init("showPicker"), object: picker)
            }
            else
            {
                print("No camera")
            }
        }
        
        let btnPhoto:UIAlertAction = UIAlertAction(title: "Thư viện", style: UIAlertActionStyle.destructive) { (btn) in
            
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerControllerSourceType.photoLibrary)!
            NotificationCenter.default.post(name: NSNotification.Name.init("showPicker"), object: picker)
        }
        
        let btnCancel:UIAlertAction = UIAlertAction(title: "Huỷ", style: .default) { (btn) in
        }
        
        alert.addAction(arr: btnPhoto, btnCamera, btnCancel)
        
        NotificationCenter.default.post(name: Notification.Name.init("showAlert"), object: alert)
    }
    
    func reset()
    {
        txtName.text = ""
        txtIdentity.text = ""
        txtPhoneNumber.text = ""
        txtAddress.text = ""
        txtMoney.text = ""
        txtPeriMoney.text = ""
        txtCycle.text = ""
        imgAvatar.image = #imageLiteral(resourceName: "avatar")
    }
    
    func validTxt()->Array<Int>
    {
        var arr:Array<Int> = Array<Int>()
        if !txtName.validString()
        {
            arr.append(txtName.tag)
        }
        if !txtIdentity.validNumber()
        {
            arr.append(txtIdentity.tag)
        }
        if !txtPhoneNumber.validNumber()
        {
            arr.append(txtPhoneNumber.tag)
        }
        if !txtAddress.validString()
        {
            arr.append(txtAddress.tag)
        }
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

extension RegistAddDebitView:UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image:UIImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            imgAvatar.image = image
            NotificationCenter.default.post(name: Notification.Name.init("dismiss"), object: nil)
        }
        else
        {
            if let image:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            {
                imgAvatar.image = image
                NotificationCenter.default.post(name: Notification.Name.init("dismiss"), object: nil)
            }
            else
            {
                NotificationCenter.default.post(name: Notification.Name.init("dismiss"), object: nil)
                NotificationCenter.default.post(name: Notification.Name.init("error"), object: "Chọn sai định dạng")
            }
        }
    }
}
