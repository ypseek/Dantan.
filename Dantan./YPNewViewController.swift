//
//  YPNewViewController.swift
//  Dantan.
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit

let newFeatureID = "newFeatureID"

class YPNewViewController: YPBaseViewController {

    
    private lazy var collectionView : UICollectionView = {
        // 布局对象
        var layout: UICollectionViewFlowLayout = YMNewfeatureLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH), collectionViewLayout: layout)
//        collectionView.delegate = self
//        collectionView.dataSource = self
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(YMNewFeatureCell.self, forCellWithReuseIdentifier: newFeatureID)
        view.addSubview(collectionView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

private class YMNewFeatureCell: UICollectionViewCell{
    private var imageIndex: Int?{
        didSet{
            iconView.image = UIImage(named: "walkthrough_\(imageIndex! + 1)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        contentView.addSubview(iconView)
    }
    
    private lazy var iconView:UIImageView = {
        let iconView = UIImageView()
        return iconView
    }()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_begin"), for: .normal)
        btn .addTarget(self, action: #selector(startBtn), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.isHidden = true
        return btn
    }()
    
    func startBtn(){
        UIApplication.shared.keyWindow?.rootViewController = YPTabbarController()
    }
    
}

private class YMNewfeatureLayout: UICollectionViewFlowLayout{
    fileprivate override func prepare() {
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        //设置contentVIew属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.isPrefetchingEnabled = true
    }
}
