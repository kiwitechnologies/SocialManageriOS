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
    
    /*
     *	@functionName	: twitterLogin
     *	@parameters		: viewController : It would be the viewController on which Alert has to show for success and failure
    * */
    
   class func twitterLogin(viewController:UIViewController){
        
        Twitter.sharedInstance().logInWithCompletion { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)")
                
                let alert = UIAlertController(title: "Log-in",
                    message: "User \(session?.userName) has logged-in successfully",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                viewController.presentViewController(alert, animated: true, completion: nil)
            } else {
                print("error: \(error!.localizedDescription)");
                
                let alert = UIAlertController(title: "Log-in",
                    message: "User \(session?.userName) has logged Out successfully",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                viewController.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
    }

    /*
     *	@functionName	: twitterLogOut
     *	@parameters		: viewController : It would be the viewController on which Alert has to show for success and failure
     * */
    
    
   class func twitterLogOut(viewController:UIViewController){
        let client = TWTRAPIClient.clientWithCurrentUser()
        print(client.userID)
        
        let userID = client.userID
        if client.userID != nil {
            Twitter.sharedInstance().sessionStore.logOutUserID(client.userID!)
            
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
    
    class func publishTweet(viewController:UIViewController, composeText:String, imageName:String?){
        let composer = TWTRComposer()
        
        composer.setText(composeText)
        composer.setImage(UIImage(named: imageName!))
        
        // Called from a UIViewController
        composer.showFromViewController(viewController) { result in
            if (result == TWTRComposerResult.Cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
            }
        }

    }
    
    /*
     *	@functionName	: getTwitterUserProfile
     * */
    class func getUserProfileWithScreenName(screenName:String){
        
        let client = TWTRAPIClient.clientWithCurrentUser()
        let request = client.URLRequestWithMethod("GET",
                                                  URL: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(screenName)",
                                                  parameters: ["include_email": "true", "skip_status": "true"],
                                                  error: nil)
        
        client.sendTwitterRequest(request) { response, data, connectionError in
            print(response, data)
           
        }
        
    }
    
}
