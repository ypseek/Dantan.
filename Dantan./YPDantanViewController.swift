//
//  YPDantanViewController.swift
//  Dantan.
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit

class YPDantanViewController: YPBaseViewController,UIScrollViewDelegate {

    var channels = [YPChannel]()
    // 标签
    weak var titlesView = UIView()
    //底部红色指示器
    weak var indicatorView = UIView()
    
    weak var contentView = UIScrollView()
    /// 当前选中的按钮
    weak var selectedButton = UIButton()
    
    var currentIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        
        YPNetworkingTool.shareNetworkTool.loadHomeTopData { (channels) in
            for channel in channels {
                let vc = YPTopicViewController()
                vc.title = channel.name!
                vc.type = channel.id!
                weakSelf!.addChildViewController(vc)
            }
            weakSelf!.setupTitlesView()  //顶部滑动
            weakSelf!.setBottomScroll()  //底部滑动
        }
        // Do any additional setup after loading the view.
    }
    
    func setupTitlesView() {
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: kTitlesViewY, width: SCREENW, height: kTitlesViewH)
        view.addSubview(bgView)
        
        let titlesView = UIView()
        titlesView.backgroundColor = YMGlobalColor()
        titlesView.frame = CGRect(x: 0, y: 0, width: SCREENW - kTitlesViewH, height: kTitlesViewH)
        bgView.addSubview(titlesView)
        self.titlesView = titlesView
        
        let indicatorView = UIView()
        indicatorView.backgroundColor = YMGlobalRedColor()
        indicatorView.height = kIndicatorViewH
        indicatorView.y = kTitlesViewH - kIndicatorViewH
        indicatorView.tag = -1
        self.indicatorView = indicatorView
        
        
        //选择按钮
        let arrowButton = UIButton()
        arrowButton.frame = CGRect(x: SCREENW - kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        arrowButton.setImage(UIImage(named: "arrow_index_down_8x4_"), for: .normal)
        arrowButton.addTarget(self, action: #selector(arrowButtonClick), for: .touchUpInside)
        arrowButton.backgroundColor = YMGlobalColor()
        bgView.addSubview(arrowButton)
        
        
        //内部子标签
        let count = childViewControllers.count
        let width = titlesView.width / CGFloat(count)
        let height = titlesView.height
        
        for index in 0..<count {
            let button = UIButton()
            button.height = height
            button.width = width
            button.x = CGFloat(index) * width
            button.tag = index
            let vc = childViewControllers[index]
            button.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(vc.title!, for: .normal)
            button.setTitleColor(UIColor.gray, for: .normal)
            button.setTitleColor(YMGlobalRedColor(), for: .disabled)
            button.addTarget(self, action: #selector(titlesClick), for: .touchUpInside)
            titlesView.addSubview(button)
            if index == 0 {
                button.isEnabled = false
                selectedButton = button
                //让按钮内部的Label根据文字来计算内容
                button.titleLabel?.sizeToFit()
                indicatorView.width = button.titleLabel!.width
                indicatorView.centerX = button.centerX
            }
        }
        
         titlesView.addSubview(indicatorView)
    }
    
    func titlesClick(button: UIButton) {
        selectedButton!.isEnabled = true
        button.isEnabled = false
        selectedButton = button
        var offset = contentView?.contentOffset
        offset?.x = CGFloat(button.tag) * contentView!.width
        contentView?.setContentOffset(offset!, animated: true)
        
        UIView.animate(withDuration: kAnimationDuration) { 
            self.indicatorView!.centerX = button.centerX
        };
    }
    
    func arrowButtonClick(button : UIButton) {
        UIView.animate(withDuration: kAnimationDuration) { 
            button.imageView!.transform = button.imageView!.transform.rotated(by: CGFloat(M_PI))
        };
    }
    
    func setBottomScroll() {
        let contentView = UIScrollView()
        contentView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH)
        contentView.delegate = self
        contentView.contentSize = CGSize(width: contentView.width * CGFloat(childViewControllers.count), height: 0)
        if #available(iOS 11.0, *) {
            contentView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        };
        contentView.isPagingEnabled = true
        view.insertSubview(contentView, at: 0)
        self.contentView = contentView
        //添加第一个控制器的view
        scrollViewDidEndScrollingAnimation(contentView)
    }
    
    
    //点击滑动调用
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let vc = childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    //手势滑动调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        let button = titlesView?.subviews[index] as! UIButton
        titlesClick(button: button)
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
