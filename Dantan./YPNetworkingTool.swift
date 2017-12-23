//
//  YPNetworkingTool.swift
//  Dantan.
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class YPNetworkingTool: NSObject {
    static let shareNetworkTool = YPNetworkingTool()
    
    //获取首页
    func loadHomeInfo(id: Int,finished:@escaping(_ homeItems: [YPHomeItem]) -> ()){
        let url = BASE_URL + "v1/channels/\(id)/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        
        Alamofire.request(url, method: .get, parameters:params).responseJSON { (responce) in
            guard responce.result.isSuccess else {
                SVProgressHUD .showError(withStatus: "加载失败")
                return
            }
            if let value = responce.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD .showError(withStatus: message)
                    return
                }
                let data = dict["data"].dictionary
                if  let items = data?["items"]?.arrayObject {
                    var homeItems = [YPHomeItem]()
                    for item in items {
                        let homeItem = YPHomeItem(dict: item as! [String : AnyObject])
                        homeItems.append(homeItem)
                    }
                    finished(homeItems)
                }
            }
        }
    }
    
    //获取顶部
    func loadHomeTopData(finished: @escaping (_ yp_channel: [YPChannel]) -> ()) {
        let url = BASE_URL + "v2/channels/preset"
        let params = ["gender": 1,
                      "generation": 1]
        Alamofire.request(url, method: .get, parameters:params).responseJSON { (responce) in
            guard responce.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            if let value = responce.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                let data = dict["data"].dictionary
                if let channels = data!["channels"]?.arrayObject {
                    var yp_channels = [YPChannel]()
                    for channel in channels {
                        let yp_channel = YPChannel(dict: channel as! [String : AnyObject])
                        yp_channels.append(yp_channel)
                    }
                    finished(yp_channels)
                }

            }
            
        }
    }
    
    //获取单品首页
    func loadProductData(finished:  @escaping(_ yp_product : [YPProduct]) -> ()){
        //SVProgressHUD.show(withStatus: "正在加载")
        let url = BASE_URL + "v2/items"
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        Alamofire.request(url,parameters : params).responseJSON { (responce) in
            guard responce.result.isSuccess else {
                SVProgressHUD.show(withStatus: "加载失败")
                return
            }
            if let value = responce.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.show(withStatus: message)
                    return
                }
                let data = dict["data"].dictionary
                if let items = data?["items"]?.arrayObject {
                    var products = [YPProduct]()
                    for item in items {
                        let itemDict = item as! [String : AnyObject]
                        if let itemData = itemDict["data"] {
                            let product = YPProduct(dict: itemData as! [String : AnyObject])
                            products.append(product)
                        }
                    }
                    finished(products)
                }
            }
        }
    }
    
    //获取单品详情数据
    func loadProductDetailData(id : Int,finished:@escaping(_ ypproductDetail:[YPProductDetailModel]) -> ()){
    
    }
}
