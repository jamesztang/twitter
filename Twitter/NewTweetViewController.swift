//
//  ViewController.swift
//  Twitter
//
//  Created by James Tang on 9/24/15.
//  Copyright © 2015 Codepath. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    var selectedIndex: Int?
    
    @IBAction func newTweetButton_OnClick(sender: AnyObject) {
        NSLog("NewTweetViewController.newTweetButton_OnClick")
        selectedIndex = nil
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("NewTweetViewController.viewDidLoad")
        
        if selectedIndex != nil {
            usernameLabel?.text = "User Name \(selectedIndex!)"
            userIdLabel?.text = "@userid\(selectedIndex!)"
            //timeLabel?.text = "\(selectedIndex)h"
            messageTextView.text = "Enter message to @userid\(selectedIndex!)"
        }
        
        let thumbImageURL = "http://www.rjjulia.com/sites/rjjulia.com/files/twitter_icon-jpg1.png"
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

}

