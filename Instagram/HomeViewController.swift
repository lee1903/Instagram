//
//  HomeViewController.swift
//  Instagram
//
//  Created by Brian Lee on 2/23/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var feed: [PFObject]?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        networkRequest()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        if let feed = feed{
//            return feed.count
//        }else{
//            return 0
//        }
//    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let feed = feed{
            return feed.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        let post = feed![indexPath.row]
        let caption = post["caption"] as! String
        let media = post["media"] as! PFFile
        media.getDataInBackgroundWithBlock { (result, error) -> Void in
            if let error = error{
                print("error getting image")
                print(error.localizedDescription)
            }else{
                let image = UIImage(data: result!)
                cell.contentImageView.image = image
            }
        }
        
        cell.captionLabel.text = caption

//        let imageUrl = stdRes["url"] as! String
//        let url = NSURL(string: imageUrl)
//        
//        cell.photoImageView.setImageWithURL(url!)
        
        return cell
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 80))
//        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
//        
//        let username = UILabel(frame: CGRect(x: 30, y: 0, width: 300, height: 30))
//        
//        let profileView = UIImageView(frame: CGRect(x: 10, y: 0
//            , width: 30, height: 30))
//        profileView.clipsToBounds = true
//        profileView.layer.cornerRadius = 15;
//        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
//        profileView.layer.borderWidth = 1;
//        
//        // Use the section number to get the right URL
//        // profileView.setImageWithURL(...)
//        headerView.addSubview(username)
//        headerView.addSubview(profileView)
//        //headerView.addSubview(username)
//        
//        // Add a UILabel for the username here
//        
//        return headerView
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//        
//    }
    
    func networkRequest(){
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                self.feed = media
                print("network request succesful")
                self.tableView.reloadData()
            } else {
                print("error retrieving data")
                print(error!.localizedDescription)
            }
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

}
