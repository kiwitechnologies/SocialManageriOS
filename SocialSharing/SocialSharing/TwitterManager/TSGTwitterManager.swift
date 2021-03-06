//
//  TSGSocialHelper-Extension(Twitter).swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 03/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation
import TwitterKit

class TSGTwitterManager {
    
    /* -------------------------------------------------------------------------------------------
     * A class is written to use the differnt features of Facebook sdk and GraphAPI
     * eg. Facebook login, Invite Friends, Get User Data, Post etc
     * It helps to Reduce the line of code in entire application to integrate facbook for using mention features.
     * —————————————————————————————————————————————-----------------------------------------------*/
    
    
    
    class func twitterLogin(success:(session:AnyObject)->(), failure:(error:AnyObject)->()){
        
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if (session != nil) {
                success(session: session!)
            } else {
                failure(error: error!)
            }
        }
        
    }
    
    /*
     *	@functionName	: twitterLogOut
     *	@parameters		: viewController : It would be the viewController on which Alert has to show for success and failure
     * */
    
    
    class func twitterLogOut(viewController:UIViewController, status:(succeed:Bool)->()){
        let client = TWTRAPIClient.clientWithCurrentUser()
        print(client.userID)
        
        let userID = client.userID
        if client.userID != nil {
            Twitter.sharedInstance().sessionStore.logOutUserID(client.userID!)
            status(succeed: true)
            let alert = UIAlertController(title: "Log Out",
                                          message: "User \(userID) has logged Out successfully",
                                          preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            viewController.presentViewController(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Log Out",
                                          message: "User \(userID) has already logged Out",
                                          preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            viewController.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    /*
     *	@functionName	: publishTweet
     *	@parameters		: viewController : It would be the viewController on which Alert has to show for success and failure
     * */
    
    class func publishTweet(viewController:UIViewController, composeText:String, imageName:String?, success:(AnyObject)->(), failure:(AnyObject)->()){
        let composer = TWTRComposer()
        
        composer.setText(composeText)
        composer.setImage(UIImage(named: imageName!))
        
        // Called from a UIViewController
        composer.showFromViewController(viewController) { result in
            if (result == TWTRComposerResult.Cancelled) {
                failure("Error")
            }
            else {
                success("Sending Tweet!")
            }
        }
        
    }
    
    /*
     *	@functionName	: getTwitterUserProfile
     * */
    class func getUserProfileWithScreenName(screenName:String, success:(response:AnyObject?, data:AnyObject?)->(), error:(error:AnyObject)->()){
        
        let client = TWTRAPIClient.clientWithCurrentUser()
        let request = client.URLRequestWithMethod("GET",
                                                  URL: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(screenName)",
                                                  parameters: ["include_email": "true", "skip_status": "true"],
                                                  error: nil)
        
        client.sendTwitterRequest(request) { response, data, connectionError in
            print(response, data)
            if response != nil && data != nil {
                success(response: response, data: data)
 
            }
            if connectionError != nil {
                error(error: connectionError!)
 
            }
        }
        
    }
    
}
