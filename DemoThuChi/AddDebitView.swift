//
//  AddDebitView.swift
//  DemoThuChi
//
//  Created by Huỳnh Công Thái on 12/14/16.
//  Copyright © 2016 Huỳnh Công Thái. All rights reserved.
//

import Foundation
import UIKit

class AddDebitView: BaseView {
    
    let arrMenu:Array<UIImage> = [#imageLiteral(resourceName: "newDebtor"), #imageLiteral(resourceName: "Debtors"), #imageLiteral(resourceName: "Persional")]
    
    let viewBackground:UIView = {
        let view:UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    let viewTapHide:UIView = {
        let view:UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0)
        return view
    }()

    
    let line:UIView =
        {
            let view:UIView = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            return view
    }()
    
    lazy var collect:UICollectionView =
        {
            let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let col:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            col.isPagingEnabled = true
            col.translatesAutoresizingMaskIntoConstraints = false
            col.register(AddDebitCollectViewCell.self, forCellWithReuseIdentifier: "AddDebitCollectViewCell")
            col.register(AddDebtsCollectViewCell.self, forCellWithReuseIdentifier: "AddDebtsCollectViewCell")
            col.register(ProfileCollectViewCell.self, forCellWithReuseIdentifier: "ProfileCollectViewCell")
            col.showsHorizontalScrollIndicator = false
            col.delegate = self
            col.dataSource = self
            return col
    }()
    
    lazy var viewMenuBar:MenuBarView =
        {
            let view:MenuBarView = MenuBarView()
            view.addDebitView = self
            return view
    }()
    
    
    override func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        setUpViewBackground()
        setUpLine()
        setUpViewTapHide()
        setUpViewMenuBar()
        setUpCollect()
    }
    
    func setUpViewBackground()
    {
        addSubview(viewBackground)
        viewBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewBackground.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 8/9).isActive = true
        viewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    func setUpLine()
    {
        viewBackground.addSubview(line)
        line.topAnchor.constraint(equalTo: viewBackground.topAnchor).isActive = true
        line.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor).isActive = true
        line.widthAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func setUpViewTapHide()
    {
        self.addSubview(viewTapHide)
        viewTapHide.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        viewTapHide.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewTapHide.leadingAnchor.constraint(equalTo: viewBackground.trailingAnchor).isActive = true
        viewTapHide.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setUpViewMenuBar()
    {
        viewBackground.addSubview(viewMenuBar)
        viewMenuBar.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor).isActive = true
        viewMenuBar.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor).isActive = true
        viewMenuBar.widthAnchor.constraint(equalTo: viewBackground.widthAnchor, constant: -2).isActive = true
        viewMenuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
         viewMenuBar.collect.selectItem(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.right)
    }
    
    private func setUpCollect()
    {
        viewBackground.addSubview(collect)
        collect.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor).isActive = true
        collect.topAnchor.constraint(equalTo: viewBackground.topAnchor).isActive = true
        collect.widthAnchor.constraint(equalTo: viewMenuBar.widthAnchor).isActive = true
        collect.bottomAnchor.constraint(equalTo: viewMenuBar.topAnchor).isActive = true
    }
    
    func ScrollTo(indexPath:IndexPath)
    {
        collect.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.right, animated: true)
    }
}

extension AddDebitView:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDebitCollectViewCell", for: indexPath) as! AddDebitCollectViewCell
            return cell
        case 1:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDebtsCollectViewCell", for: indexPath) as! AddDebtsCollectViewCell
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectViewCell", for: indexPath) as! ProfileCollectViewCell
            cell.centerY.constant = cell.frame.height
            return cell
        }
        
//        if indexPath.row % 2 != 0
//        {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDebtsCollectViewCell", for: indexPath) as! AddDebtsCollectViewCell
//            return cell
//        }
//        else
//        {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddDebitCollectViewCell", for: indexPath) as! AddDebitCollectViewCell
//            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index:Int = Int(scrollView.contentOffset.x / scrollView.frame.width)
        viewMenuBar.collect.selectItem(at: IndexPath.init(row: index, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.top)
    }
}
