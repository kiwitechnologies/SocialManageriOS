//
//  SocialListViewController.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 02/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

class SocialListViewController: UIViewController {
    
    let socialList = ["Facebook","Twitter","Instagram","Linkedin","Google"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
          
}

extension SocialListViewController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SocialListCell", forIndexPath:indexPath) as UITableViewCell
        cell.textLabel?.text = socialList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let socialFeautreObj = self.storyboard?.instantiateViewControllerWithIdentifier("SocialFeatures") as? SocialFeatures
            
        switch indexPath.row {
            
        case SocialPlatformName.FACEBOOK.hashValue:
            socialFeautreObj?.socialPlatform = SocialPlatformName.FACEBOOK
            self.navigationController?.pushViewController(socialFeautreObj!, animated: true)

            break
            
        case SocialPlatformName.LINKEDIN.hashValue:
            socialFeautreObj?.socialPlatform = SocialPlatformName.LINKEDIN
            self.navigationController?.pushViewController(socialFeautreObj!, animated: true)

            break
         
        case SocialPlatformName.INSTAGRAM.hashValue:
            socialFeautreObj?.socialPlatform = SocialPlatformName.INSTAGRAM
            //self.navigationController?.pushViewController(instagramLogin, animated: true)
            self.navigationController?.pushViewController(socialFeautreObj!, animated: true)

            break
            
        case SocialPlatformName.TWITTER.hashValue:
            socialFeautreObj?.socialPlatform = SocialPlatformName.TWITTER
            self.navigationController?.pushViewController(socialFeautreObj!, animated: true)

            break
        case SocialPlatformName.GOOGLE.hashValue:

            socialFeautreObj?.socialPlatform = SocialPlatformName.GOOGLE
            self.navigationController?.pushViewController(socialFeautreObj!, animated: true)

        default:
            break
        }
    }
}