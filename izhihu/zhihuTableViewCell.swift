//
//  zhihuTableViewCell.swift
//  izhihu
//
//  Created by swift on 15/10/29.
//  Copyright © 2015年 swift. All rights reserved.
//

import UIKit
import Alamofire
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

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var storyTitle: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var popularityCount: UILabel!
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
        let url = NEWS_EXTRA_INFO + "\(self.story!.id!)"
        Alamofire.request(.GET, url )
            .responseJSON { response in
                //print("\(response)")
                let json = JSON(response.result.value!)
            
                let popularity = json["popularity"].int
                self.popularityCount.text = "\(popularity!)"
                let commentCount = json["comments"].int
                self.commentCount.text =  "\(commentCount!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

