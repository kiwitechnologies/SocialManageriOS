//
//  TwitterPostsViewController.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 05/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterPostsViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TWTRAPIClient.clientWithCurrentUser()
       // self.dataSource = TWTRSearchTimelineDataSource.init(searchQuery: "#ForABetterTomorrow", APIClient: client)
         self.dataSource = TWTRUserTimelineDataSource(screenName: "Yogesh774", APIClient: client)
        self.showTweetActions = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
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
