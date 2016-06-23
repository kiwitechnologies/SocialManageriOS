//
//  SocialFeatures-Extension(Instagram).swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 09/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

extension SocialFeatures {
    
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
            
        case 4:
            instagramLogOut()
            
        default:
            break
        }
    }
    
    func InstagramLogin(){
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramLoginViewController") as! InstagramLoginViewController
        self.navigationController?.pushViewController(instagramLogin, animated: true)
    }
    
    func getInstagramUserProfile(){
        
        TSGInstagramManager.sharedInstance.instagramUserProfile({ (object) in
            print(object)
        }) { (error) in
            print(error)
        }        }
    
    func getMyPublishMedia(){
        let image = UIImage(named: "IMG_4301.jpg", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)

        if image != nil {
            TSGInstagramManager.sharedInstance.instagramPostImage(self.view, image: image!) { (status) in
                print(status)
            }
        }
    }
    
    func getFriendsProfile(){
        
        TSGInstagramManager.sharedInstance.instagramFriendProfile("3314177362", successBlock: { (object) in
            print(object)
            }) { (failure) in
                print(failure)
        }
    }
    
    func instagramLogOut(){
        TSGInstagramManager.sharedInstance.instagramLogOut { (status) in
            print(status)
        }
    }
}
