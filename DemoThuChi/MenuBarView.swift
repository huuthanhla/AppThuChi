//
//  MenuBarView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/15/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class MenuBarView: BaseView {
    
    var addDebitView:AddDebitView!
    
    lazy var collect:UICollectionView =
        {
            let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let coll:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            coll.translatesAutoresizingMaskIntoConstraints = false
            coll.register(menuBarCollectViewCell.self, forCellWithReuseIdentifier: "menuBarCollectViewCell")
            layout.scrollDirection = .horizontal
            coll.backgroundColor = UIColor.clear
            coll.delegate = self
            coll.dataSource = self
            return coll
    }()
    
    override func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.7613929296, blue: 0.7201619339, alpha: 1)
        setUpCollect()
    }
    
    func setUpCollect()
    {
        self.addSubview(collect)
        collect.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collect.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        collect.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        collect.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}

extension MenuBarView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addDebitView.arrMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuBarCollectViewCell", for: indexPath) as! menuBarCollectViewCell
        
        cell.imgIcon.image = addDebitView.arrMenu[indexPath.row].withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collect.frame.width/CGFloat(addDebitView.arrMenu.count), height: collect.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addDebitView.ScrollTo(indexPath: indexPath)
    }
}

