//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by James Tang on 9/24/15.
//  Copyright © 2015 Codepath. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweets: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HomeTableViewController.viewDidLoad")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        print("HomeTableViewController.viewDidAppear")
        
        
        let twitterURLString = "http://localhost/~ztang1/twitter.json"
        let request = NSMutableURLRequest(URL: NSURL(string: twitterURLString)!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSArray {
                dispatch_async(dispatch_get_main_queue()) {
                    self.tweets = dictionary
                    self.tableView.reloadData()
                    NSLog("Dictionary: \(self.tweets)")
                }
            }
            else {
                print("no data")
            }
        }
        task.resume()
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
        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Tweet Cell", forIndexPath: indexPath) as! TweetTableViewCell

        cell.usernameLabel?.text = "User Name \(indexPath.row)  @userid\(indexPath.row)"
        cell.timeLabel?.text = "\(indexPath.row)h"
        cell.messageLabel.text = "Message \(indexPath.row)"
        let thumbImageURL = "http://www.rjjulia.com/sites/rjjulia.com/files/twitter_icon-jpg1.png"
        if let checkedThumbImageURL = NSURL(string: thumbImageURL) {
            downloadImage(checkedThumbImageURL, imageView: cell.userImageView)
        }
        return cell
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cell = sender as? UITableViewCell {
            print("go to view tweet")
            let indexPath = tableView.indexPathForCell(cell)!
            
            let tweetViewController = segue.destinationViewController as! TweetViewController
            tweetViewController.selectedIndex = indexPath.row
        }
        else {
            print("go to new tweet")
        }
    }


    func downloadImage(url:NSURL, imageView: UIImageView) {
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = UIImage(data: data!)
            }
        }
    }
    
    func getDataFromUrl(urL: NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }

}

class TweetTableViewCell : UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
}