//
//  SocialFeatures-Extension(Twitter).swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 02/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation
import UIKit

extension SocialFeatures {
    
    func  getTwitterFeautres(index:Int, viewController:UIViewController){
        
        switch index {
            
        case 0:
            twitterLogin()
            
        case 1:
            getTwitterUserProfile()
            
        case 2:
            publishTweet()
            
        case 3:
            getAllPost()
            
        case 4:
            twitterLogOut()
            
        default:
            break
        }
    }
    
    func twitterLogin(){
        
        TSGTwitterManager.twitterLogin({ (session) in
            print(session)
        }) { (error) in
            print(error)
            
        }
    }
    
    func twitterLogOut(){
        
        TSGTwitterManager.twitterLogOut(self) { (succeed) in
            print(succeed)
        }
    }
    
    func getAllPost(){
        let socialFeautreObj = self.storyboard?.instantiateViewControllerWithIdentifier("TwitterAllPosts") as! TwitterPostsViewController
        self.navigationController?.pushViewController(socialFeautreObj, animated: true)
        
    }
    
    func publishTweet(){
        TSGTwitterManager.publishTweet(self, composeText: "just setting up my Fabric", imageName: "abc.png", success: { (object) in
            print(object)
        }) { (error) in
            print(error)
        }
    }
    
    func getTwitterUserProfile(){
        
        TSGTwitterManager.getUserProfileWithScreenName("Yogesh774", success: { (response, data) in
            print(response)
        }) { (error) in
            print(error)
        }
    }
    
    
}