//
//  zhihuNewsTableViewController.swift
//  izhihu
//
//  Created by swift on 15/10/28.
//  Copyright © 2015年 swift. All rights reserved.
//

import UIKit
import Alamofire

class zhihuNewsTableViewController: UITableViewController {
    let newsLatest = "http://news-at.zhihu.com/api/4/news/latest"
    var news = [Story]()
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "zhihuTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "zhihuTableViewCell")
        
        //auto calc size
       
        
            Alamofire.request(.GET, newsLatest)
                .responseJSON { response in
                    let json = JSON(response.result.value!)
                    for (_,storyJSON):(String,JSON) in json["stories"]{
                        //print("\(storyJSON)")
                        let story = Story(id : storyJSON["id"].int,title : storyJSON["title"].string, imageUrl : storyJSON["images",0].string)
                        self.news.append(story)
                    }
                    //print("json\(self.news[0])")
                    print("count :\(self.news.count)")
                    self.tableView!.reloadData()
            }
        //self.tableView.estimatedRowHeight = self.tableView.rowHeight
        //self.tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("zhihuTableViewCell", forIndexPath: indexPath) as! zhihuTableViewCell
        
        
        let story = news[indexPath.row]
        //let cell = zhihuTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "newsCell")
        cell.story = story
        // Configure the cell...
        
        return cell
    }
    // UITableViewDelegate 方法，处理列表项的选中事件
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! zhihuTableViewCell
        
        self.performSegueWithIdentifier("showNewsDetail", sender: cell)
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //         Get the new view controller using segue.destinationViewController.
        //         Pass the selected object to the new view controller.
        print("prepare for segue"   )
        if let cell = sender as? zhihuTableViewCell  {
            let vc = segue.destinationViewController as! zhihuNewsDetailControllerViewController
            vc.id = cell.story?.id
        }
        
    }

}
