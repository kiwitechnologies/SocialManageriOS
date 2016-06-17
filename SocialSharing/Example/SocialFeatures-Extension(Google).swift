//
//  SocialFeatures-Extension(Google).swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 12/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import SafariServices
import GoogleAPIClient
import GTMOAuth2


extension SocialFeatures{
    
    func getGoogleFeature(index:Int, viewController:UIViewController){
        switch index {
            
        case 0:
            googleLogin()
            
        case 1:
            googleSharing()
            
        case 2:
            googleCalendar()
            
        case 3:
            googleLogOut()
            
        default:
            break
        }
    }

    func googleLogOut(){
        
        let googleObj = self.storyboard?.instantiateViewControllerWithIdentifier("GoogleViewController") as! GoogleViewController
        googleObj.ggleOptions = GoogleOptions.GoogleLogOut
        self.navigationController?.pushViewController(googleObj, animated: true)

    }
    
    func googleLogin(){
        
        let googleObj = self.storyboard?.instantiateViewControllerWithIdentifier("GoogleViewController") as! GoogleViewController
        googleObj.ggleOptions = GoogleOptions.GOOGLE_LOGIN
        self.navigationController?.pushViewController(googleObj, animated: true)
 

    }
    
    func googleSharing(){
        
        let googleObj = self.storyboard?.instantiateViewControllerWithIdentifier("GoogleViewController") as! GoogleViewController
        googleObj.ggleOptions = GoogleOptions.GoogleSharing
        googleObj.shareURL = "https://library.launchkit.io/how-ios-9-s-safari-view-controller-could-completely-change-your-app-s-onboarding-experience-2bcf2305137f#.66vosfp4j"
        self.navigationController?.pushViewController(googleObj, animated: true)

    }
    
    func googleCalendar(){
        let googleObj = self.storyboard?.instantiateViewControllerWithIdentifier("GoogleViewController") as! GoogleViewController
        googleObj.ggleOptions = GoogleOptions.GoogleCalendar
        self.navigationController?.pushViewController(googleObj, animated: true)
    }
}