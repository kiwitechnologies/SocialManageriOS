//
//  SocialListViewController.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 02/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import TSGServiceClient

class SocialListViewController: UIViewController {
    
    let socialList = ["Facebook","Twitter","Instagram","Linkedin","Google"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        
//        let queryParam = ["access_token":"3314177362.5a3f599.0129421c607545d3902fcc3fb31826a0"]
//        
//        let tempDict:NSMutableDictionary = NSMutableDictionary()
//        tempDict.setValue("3314177362", forKey: "user-id")

//        TSGServiceManager.performAction("5759249a62c18b953cf00e7f", withQueryParam: queryParam, withPathParams: tempDict, onSuccess: { (object) in
//            
//            print(object)
//            }) { (bool, error) in
//                print(error)
//   
//        }
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
        
        //let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramView") as! InstagramViewController
        
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