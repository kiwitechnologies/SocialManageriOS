//
//  LinkedinManager.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 10/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

class LinkedinManager: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var linkedinOption:LinkedinOptions!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch linkedinOption! {
        case .LINKEDIN_LOGIN:
            linkedINLogin()

        case .LINKEDIN_LOGOUT:
            linkedinLogOut()

        case .LINKEDIN_SHARE:
            shareOnLinkedin()
            
        case .LINKEDIN_USER_PROFILE:
            linkedInUserProfile()
            
        }
        
    }

    func linkedINLogin(){
        LISDKSessionManager.createSessionWithAuth([LISDK_BASIC_PROFILE_PERMISSION,LISDK_W_SHARE_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: { (response) in
            
            print(response)
        }) { (error) in
            print(error)
        }

    }
    
    func linkedInUserProfile(){
      
        let url = "https://api.linkedin.com/v1/people/~"
        if LISDKSessionManager.hasValidSession() {
            
            LISDKAPIHelper.sharedInstance().getRequest(url, success: { (response) in
                let dataStr = response.data
                
                print(dataStr)
                
                }, error: { (error) in
                    print(error)
                    
            })
        }

    }
    
    func shareOnLinkedin(){
        
        let url = "https://api.linkedin.com/v1/people/~/shares"
        let comment = ["comment":"Final Test Going on!"]
        let visiblityArray = [ "code":"anyone" ]
        let visibility = ["visibility":visiblityArray]
        
        let shareMessage:NSMutableDictionary = NSMutableDictionary()
        shareMessage.addEntriesFromDictionary(comment)
        shareMessage.addEntriesFromDictionary(visibility)
        
        do {
            
            let theJSONData = try NSJSONSerialization.dataWithJSONObject(shareMessage, options: NSJSONWritingOptions(rawValue: 1))
            let payload = String(data: theJSONData,
                                 encoding: NSUTF8StringEncoding)
            print(payload!)
            
            if LISDKSessionManager.hasValidSession() {
                
                LISDKAPIHelper.sharedInstance().postRequest(url, stringBody: payload!, success: { (response) in
                    
                    print("Success Response: = \(response!)")
                    
                    }, error: { (error) in
                        print("Failure Response: = \(error!)")
                        
                })
            }
            
        } catch {}
        
    }
    
    func linkedinLogOut(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


