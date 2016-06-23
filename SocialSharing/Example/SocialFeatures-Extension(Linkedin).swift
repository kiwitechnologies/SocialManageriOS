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
            
        case 4:
            linkedinLogOut()
        default:
            break
        }
    }
    
    func linkedInLogin(){
        
        TSGLinkedinManager.linkedINLogin({ (object) in
            print(object)
            }, failureBlock: { (error) in
                print(error)
        }) { (hasSession) in
            print("Has already session?: \(hasSession)")
        }
    }
    
    func getLinkedinUserProfile(){
        
        TSGLinkedinManager.linkedInUserProfile({ (object) in
            print(object)
        }) { (error) in
            print(error)
        }
    }
    
    func shareOnLinkedin(){
        let comment = ["comment":"Final Test Going on!"]
        let visiblityArray = [ "code":"anyone" ]
        
        TSGLinkedinManager.shareOnLinkedin(comment, visbilityArray: visiblityArray, success: { (object) in
            print(object)
            }) { (failure) in
                print(failure)
        }
    }
    
    func linkedinLogOut(){
        
        TSGLinkedinManager.linkedinLogOut { (status) in
            print(status)
        }
        
    }
}
