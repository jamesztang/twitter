//
//  TweetViewController.swift
//  Twitter
//
//  Created by James Tang on 9/24/15.
//  Copyright © 2015 Codepath. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!

    var selectedIndex: Int!
    var thumbImageURL: String!
    var username: String!
    var userId: String!
    var message: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        usernameLabel?.text = "User Name \(selectedIndex)"
//        userIdLabel?.text = "@userid\(selectedIndex)"
//        //timeLabel?.text = "\(selectedIndex)h"
//        messageTextView.text = "Message \(selectedIndex)"
//
//        let thumbImageURL = "http://www.rjjulia.com/sites/rjjulia.com/files/twitter_icon-jpg1.png"
        
        usernameLabel?.text = username
        userIdLabel?.text = userId
        //timeLabel?.text = "\(selectedIndex)h"
        messageTextView.text = message
        if let checkedThumbImageURL = NSURL(string: thumbImageURL) {
            downloadImage(checkedThumbImageURL, imageView: thumbImageView)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let tweetViewController = segue.destinationViewController as! NewTweetViewController
        tweetViewController.selectedIndex = selectedIndex
    }

}
