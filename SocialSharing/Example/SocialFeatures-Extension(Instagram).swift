//
//  SocialFeatures-Extension(Instagram).swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 09/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

extension SocialFeatures {
    
    /*
     Get Profile
     Share Image
     Share Video
     User Profile
     Self Recent Media
     User Recent Media
     Follows
     Followed By
     Logout
     */
    
    func getInstagramFeatures(index:Int, viewController:UIViewController){
        
        switch index {
            
        case 0:
            InstagramLogin()

        case 1:
            getInstagramUserProfile()
            
        case 2:
            getFriendsProfile()

        case 3:
            getMyPublishMedia()
            
        case 5:
            instagramLogOut()
            
        default:
            break
        }
    }
    
    func InstagramLogin(){
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramView") as! InstagramViewController
        self.navigationController?.pushViewController(instagramLogin, animated: true)
    }
    
    func getInstagramUserProfile(){

        TSGInstagramManager.sharedInstance.instagramUserProfile({ (object) in
            print(object)
            }) { (error) in
                print(error)
        }        }
    
    func getMyPublishMedia(){
        
        TSGInstagramManager.sharedInstance.instagramPostImage(self.view)
    }
    
    func getFriendsProfile(){
        
     TSGInstagramManager.sharedInstance.instagramFriendProfile({ (object) in
        print(object)
        }) { (error) in
            print(error)
        }
    }
    
    func publishPhoto(){
        TSGInstagramManager.sharedInstance.instagramPublishMedia({ (object) in
            print(object)
            }) { (error) in
                print(error)
        }
    }
    
    func instagramLogOut(){
         TSGInstagramManager.sharedInstance.instagramLogOut()
    }
}
