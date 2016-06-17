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
            
        case 4:
            publishPhoto()
            
            
        default:
            break
        }
    }
    
    func InstagramLogin(){
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramView") as! InstagramViewController
        instagramLogin.IMOptions = InstagramOptions.INSTAGRAM_LOGIN
        self.navigationController?.pushViewController(instagramLogin, animated: true)
    }
    
    func getInstagramUserProfile(){
        
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramView") as! InstagramViewController
        instagramLogin.IMOptions = InstagramOptions.INSTAGRAM_USER_PROFILE
        self.navigationController?.pushViewController(instagramLogin, animated: true)

        }
    
    func getMyPublishMedia(){
        
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramView") as! InstagramViewController
        instagramLogin.IMOptions = InstagramOptions.INSTAGRAM_PUBLISH_POST
        self.navigationController?.pushViewController(instagramLogin, animated: true)

        
    }
    
    func getFriendsProfile(){
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramView") as! InstagramViewController
        instagramLogin.IMOptions = InstagramOptions.INSTAGRAM_FRIEND_PROFILE
        self.navigationController?.pushViewController(instagramLogin, animated: true)

    }
    
    func publishPhoto(){
        
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("InstagramView") as! InstagramViewController
        instagramLogin.IMOptions = InstagramOptions.INSTAGRAM_PUBLISH_POST
        self.navigationController?.pushViewController(instagramLogin, animated: true)
      }
}
