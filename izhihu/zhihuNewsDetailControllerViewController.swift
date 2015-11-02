//
//  zhihuNewsDetailControllerViewController.swift
//  izhihu
//
//  Created by swift on 15/10/29.
//  Copyright © 2015年 swift. All rights reserved.
//

import UIKit
import Alamofire
class zhihuNewsDetailControllerViewController: UIViewController {

    @IBOutlet weak var newsDetailWebview: UIWebView!
    @IBOutlet weak var likeCountItem: UINavigationItem!
    var  id : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail id : \(id)")
        Alamofire.request(.GET, "http://news-at.zhihu.com/api/4/news/" + "\(id)" )
            .responseJSON { response in
                let json = JSON(response.result.value!)
                let body = json["body"].string
                var css = ""
                for (_,cssJson) in json["css"] {
                    css = "<link href='\(cssJson)' rel='stylesheet' type='text/css' />\(css)"
                }
                let newBody = "\(css) <style> .headline .img-place-holder { height: 200px;}</style> \(body!)"
                //print("\(newBody)")
                self.newsDetailWebview.loadHTMLString(newBody,baseURL:nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
