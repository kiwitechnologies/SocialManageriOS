//
//  ViewController.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 01/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import GoogleAPIClient
import GTMOAuth2

var docFile:UIDocumentInteractionController?

class SocialFeatures: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var featuresArr:NSArray?
    let socialFeaturesDict:NSMutableDictionary = NSMutableDictionary.init(dictionary: PersistentDataManager.socialListDictionary)
    var socialPlatform:SocialPlatformName!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "\(socialPlatform)"
        
        featuresArr = socialFeaturesDict.valueForKey(("\(socialPlatform!)")) as? NSArray

        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SocialFeatures:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if featuresArr != nil {
            return (featuresArr?.count)! }
        else { return 0 }
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fbTableViewCell", forIndexPath:indexPath) as UITableViewCell
        cell.textLabel?.text = featuresArr![indexPath.row] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch socialPlatform.hashValue {
            
        case SocialPlatformName.FACEBOOK.hashValue:
            getFBFeature(indexPath.row, viewController: self)
            break
            
        case SocialPlatformName.LINKEDIN.hashValue:
            getLinkedinFeature(indexPath.row, viewController: self)
            break
            
        case SocialPlatformName.INSTAGRAM.hashValue:
            getInstagramFeatures(indexPath.row, viewController: self)
            break
            
        case SocialPlatformName.TWITTER.hashValue:
            getTwitterFeautres(indexPath.row, viewController: self)
            break
            
        case SocialPlatformName.GOOGLE.hashValue:
            getGoogleFeature(indexPath.row, viewController: self)
            break
        default:
            break
        }
    }
}
