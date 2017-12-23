//
//  YPTabbarController.swift
//  Dantan.
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit

class YPTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = YMColor(r: 245, g: 90, b: 93, a: 1/0)
        addchildControllers()
        // Do any additional setup after loading the view.
    }

    private func addchildControllers(){
        addchildController(childController: YPDantanViewController(), title: "单糖", imageName: "TabBar_home_23x23_")
        addchildController(childController: YPProductViewController(), title: "单品", imageName: "TabBar_gift_23x23_")
        addchildController(childController: YPCategoryViewController(), title: "分类", imageName: "TabBar_category_23x23_")
        addchildController(childController: YPMeViewController(), title: "我的", imageName: "TabBar_me_boy_23x23_")
    }
    
    private func addchildController(childController : UIViewController,title : String, imageName : String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        childController.title = title
        let navC = YPNavigationViewController(rootViewController: childController)
        addChildViewController(navC)
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
