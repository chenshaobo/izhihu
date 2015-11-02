//
//  zhihuTableViewCell.swift
//  izhihu
//
//  Created by swift on 15/10/29.
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

class zhihuTableViewCell: UITableViewCell {
    
    var story : Story?{
        didSet {
            update()
        }
    }

    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    
    func update(){	
        self.storyTitle!.text = story!.title
        if let imageUrl = story?.imageUrl {
            
            dispatch_async(dispatch_get_main_queue()){
                ImageLoader.sharedLoader.imageForUrl(imageUrl, completionHandler:{(image: UIImage?, url: String) in
                    //print("size\(image?.size)")
                    self.storyImage.image = image
                })
            }
        }
    }
}

