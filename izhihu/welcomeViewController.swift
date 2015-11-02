//
//  welcomeViewController.swift
//  izhihu
//
//  Created by swift on 15/10/29.
//  Copyright © 2015年 swift. All rights reserved.
//

import UIKit
import Alamofire
class welcomeViewController: UIViewController {
    
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var welcomeImg: UIImageView!
    var navController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWelcomImg()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //本视图显示前
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    //本视图显示后动作
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //开始设置动画,这个动画是渐变放大
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(TIME_DURATION)
        let transform = CGAffineTransformMakeScale(	1.15, 1.15)
        self.welcomeImg.transform = transform
        UIView.commitAnimations()
        //启动一个定时器,到时间后执行 presentNextViewController: 方法
        NSTimer.scheduledTimerWithTimeInterval(TIME_DURATION, target: self, selector: "presentNextViewController:", userInfo: self.navController, repeats: false)
    }

    func displayWelcomImg() {
        
        dispatch_async(dispatch_get_main_queue()){
            Alamofire.request(.GET, WELCOME_IMG_URL)
                .responseJSON { response in
                    let json = JSON(response.result.value!)
                    let imageUrl = json["img"].string
                    let ownerStr = json["text"].string
                     self.ownerLabel.text = ownerStr!
                    ImageLoader.sharedLoader.imageForUrl(imageUrl!, completionHandler:{(image: UIImage?, url: String) in
                        print("size\(image!) string \(ownerStr)")
                         self.welcomeImg.image = image!
                       
                    })
            }
            
          
        }
    }
    
    //动画显示完毕后,把页面跳转到主视图
    func presentNextViewController(timer:NSTimer){
        print("\(timer.userInfo as? UINavigationController)")
        let rootNavigationViewController:UINavigationController = timer.userInfo as! UINavigationController
        self.presentViewController(rootNavigationViewController, animated: true) { () -> Void in
            print("main topic")
            }
        }
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    class func getWelcomViewController(navController: UINavigationController)-> welcomeViewController   {
        let instance = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("welcome") as! welcomeViewController
        instance.navController  = navController
        print("get welcome \(instance.navController)")
        return  instance
    }

}


