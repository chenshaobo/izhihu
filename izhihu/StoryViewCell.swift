//
//  StoryViewCell.swift
//  izhihu
//
//  Created by swift on 15/10/28.
//  Copyright © 2015年 swift. All rights reserved.
//

import UIKit
struct Story {
    init(id:Int?,title:String?,imageUrl:String?){
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
    }
    let id:Int?
    let title :String?
    let imageUrl: String?
}
class StoryViewCell: UITableViewCell {

    var story : Story?{
        didSet {
            update()
        }
    }
//    init(){
//    
//    }
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    var id:String?

    func update(){
        print("UPDAT:\(story)")
        self.storyTitle!.text = story!.title
            if let imageUrl = story?.imageUrl {

            dispatch_async(dispatch_get_main_queue()){
                ImageLoader.sharedLoader.imageForUrl(imageUrl, completionHandler:{(image: UIImage?, url: String) in
                    print("size\(image?.size)")
                    self.storyImage.image = image
                    print("\(self.storyImage.sizeThatFits(CGSize(width:48,height:48 )))")
                    //self.storyImage.frame = CGRectMake(0, 0, 48.0, 48.0)
                    self.storyImage.layer.cornerRadius = self.storyImage.frame.size.width / 2
                })
//                NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, _, error) -> Void in
//                    guard let data = data where error == nil else { return }
////                    print("get data ok :\(url)\n\(data)")
////                    self.story!.imageData = data
//                    self.storyImage.image = UIImage(data:data)
//                }).resume()
            }
           }
    }
}


extension UIImageView {
    func downloadedFrom(link link:String) {
        if let url = NSURL(string: link) {
            dispatch_async(dispatch_get_main_queue()){
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, _, error) -> Void in
                guard let data = data where error == nil else { return }
                self.image = UIImage(data: data)
            }).resume()
            }
        }
    }
}