//
//  StoryViewCell.swift
//  izhihu
//
//  Created by swift on 15/10/28.
//  Copyright © 2015年 swift. All rights reserved.
//

import UIKit
struct Story {
    init(id:String?,title:String?,imageUrl:String?){
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
    }
    let id:String?
    let title :String?
    let imageUrl: String?
    var imageData : NSData?
}
class StoryViewCell: UITableViewCell {

    var story : Story?{
        didSet {
            update()
        }
    }
    @IBOutlet weak var storyTitle: UITextView!
    @IBOutlet weak var storyImage: UIImageView!
    var id:String?
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(){
        print("UPDAT:\(story)")
        self.storyTitle!.text = story!.title
//        if ((self.storyTitle!.text = story!.title) != nil) {}

        if let data = story!.imageData {
                print("set image data")
                self.storyImage.image = UIImage( data: data)
        }else{
            if let imageUrl = story?.imageUrl {
            if let url = NSURL(string: (imageUrl)) {
            dispatch_async(dispatch_get_main_queue()){
                NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, _, error) -> Void in
                    guard let data = data where error == nil else { return }
//                    print("get data ok :\(url)\n\(data)")
//                    self.story!.imageData = data
                    self.storyImage.image = UIImage(data:data)
                }).resume()
            }
            }
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