//
//  SocialFeatures-Extension(Linkedin).swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 10/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

extension SocialFeatures {
    
    func getLinkedinFeature(index:Int, viewController:UIViewController){
        
        switch index {
            
        case 0:
            linkedInLogin()
            
        case 1:
            getLinkedinUserProfile()
            
        case 2:
            shareOnLinkedin()
            
        default:
            break
        }
    }
    
    func linkedInLogin(){
        
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("LinkedinView") as! LinkedinManager
        instagramLogin.linkedinOption = LinkedinOptions.LINKEDIN_LOGIN
        self.navigationController?.pushViewController(instagramLogin, animated: true)

    }
    
    func getLinkedinUserProfile(){
    
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("LinkedinView") as! LinkedinManager
        instagramLogin.linkedinOption = LinkedinOptions.LINKEDIN_USER_PROFILE
        self.navigationController?.pushViewController(instagramLogin, animated: true)        
    }
    
    func shareOnLinkedin(){
        
        let instagramLogin = self.storyboard?.instantiateViewControllerWithIdentifier("LinkedinView") as! LinkedinManager
        instagramLogin.linkedinOption = LinkedinOptions.LINKEDIN_SHARE
        self.navigationController?.pushViewController(instagramLogin, animated: true)
    }
}
