//
//  Extention.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/16/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

extension UILabel
{
    func setUpLblTitle(title:String, txtColor:UIColor, fontSize:CGFloat, cornerRadius:CGFloat?, textAlignment: NSTextAlignment)
    {
        self.text = title
        self.textColor = txtColor
        self.font = UIFont(name: "Times New Roman", size: fontSize)
        self.textAlignment = textAlignment
        self.numberOfLines = 0
        if cornerRadius != nil
        {
            self.layer.cornerRadius = cornerRadius!
            self.clipsToBounds = true
        }
    }
}

extension UIFont {
    
    
    //.TraitCondensed, .TraitBold, .TraitItalic
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
}

extension UITextField
{
    func setUp()
    {
        self.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.font = UIFont(name: "Times New Roman", size: 18)
        self.minimumFontSize = 13
        self.textAlignment = .left
        self.borderStyle = .roundedRect
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done:UIBarButtonItem = UIBarButtonItem(title: "Xong", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.endEdit))
        
    
        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        self.inputAccessoryView = doneToolbar
        
    }
    
    func endEdit()
    {
        self.endEditing(true)
    }
    
    func validString()->Bool
    {
        let whitespaceSet = NSCharacterSet.whitespaces
        if self.text!.trimmingCharacters(in: whitespaceSet).isEmpty
        {
            
            return false
        }
        return true
    }
    
    func validNumber()->Bool
    {
        if Int(self.text!) == nil
        {
            return false
        }
        return true
    }
    
    func setNormal()
    {
        self.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0).cgColor
    }
    
    func setError()
    {
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
        self.layer.cornerRadius = 5
    }

}

extension UIButton
{
    func setUp()
    {
        self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState.normal)
        self.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .highlighted)
    }
}

extension UIAlertController
{
    func addAction(arr:UIAlertAction...)
    {
        for i in arr
        {
            self.addAction(i)
        }
    }
}

extension UIImageView
{
    func loadImage(link:String)
    {
        let activity:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.color = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        self.addSubview(activity)
        activity.frame = self.bounds
        activity.startAnimating()
        let url:URL = URL(string: link)!
        let queue = DispatchQueue(label: "loadImage")
        queue.async {
            do
            {
                let data:Data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    activity.stopAnimating()
                    activity.removeFromSuperview()
                }
            }
            catch
            {
                DispatchQueue.main.async {
                    self.image = #imageLiteral(resourceName: "imgError")
                    activity.stopAnimating()
                }
            }
        }
        
    }
}
