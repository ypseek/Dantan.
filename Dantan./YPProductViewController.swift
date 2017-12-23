//
//  YPProductViewController.swift
//  Dantan.
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit

let collectionCellID = "YPProductCollectionViewCell"

class YPProductViewController: YPBaseViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var products = [YPProduct]()
    
    
    var collectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        weak var weakSelf = self;
        YPNetworkingTool.shareNetworkTool.loadProductData { (products) in
            weakSelf?.products = products
            //weakSelf?.collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        let nib = UINib(nibName: String(describing: YPProductCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: collectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }

    //MARK : - UICollectionViewDatasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath) as! YPProductCollectionViewCell
        cell.product = products[indexPath.item]
        return cell
    }
    
    
    //MARK : - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
   
}
