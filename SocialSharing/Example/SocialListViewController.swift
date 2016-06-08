//
//  SocialListViewController.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 02/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

class SocialListViewController: UIViewController {
    
    let socialList = ["Facebook","Twitter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //Mark: - UITableViewData Source & UITableViewDelegate
    
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
            break
            
        case SocialPlatformName.LINKEDIN.hashValue:
            socialFeautreObj?.socialPlatform = SocialPlatformName.LINKEDIN
            break
            
        case SocialPlatformName.TWITTER.hashValue:
            socialFeautreObj?.socialPlatform = SocialPlatformName.TWITTER
            break
            
        default:
            break
        }
        self.navigationController?.pushViewController(socialFeautreObj!, animated: true)
    }
}