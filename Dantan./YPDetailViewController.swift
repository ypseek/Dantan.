//
//  YPDetailViewController.swift
//  Dantan.
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 huahan. All rights reserved.
//

import UIKit
import SVProgressHUD

class YPDetailViewController: YPBaseViewController,UIWebViewDelegate {

    var homeItem : YPHomeItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = UIWebView()
        webView.frame = view.bounds
        webView.dataDetectorTypes = .all
        webView.scalesPageToFit = true
        webView.delegate = self
        let request = URLRequest(url: URL(string : homeItem!.content_url!)!)
        webView.loadRequest(request)
        view.addSubview(webView)
        // Do any additional setup after loading the view.
    }

    //MARK: - UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.setStatus("正在加载...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

}
