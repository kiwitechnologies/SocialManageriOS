//
//  LinkedinManager.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 10/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

class TSGLinkedinManager {
    
    /* -------------------------------------------------------------------------------------------
     * A class is written to use the differnt features of Linkedin sdk and GraphAPI
     * eg. Linkedin login, Linkedin LogOut, Linkedin User Profile, Linkedin Share
     * It helps to Reduce the line of code in entire application to integrate facbook for using mention features.
     * —————————————————————————————————————————————-----------------------------------------------*/
    
    
    /*
     *	@functionName	: linkedINLogin
     *  description: This method is used to login or to check if session is already there.
     * */
    
    class func linkedINLogin(successBlock:(AnyObject)->(),failureBlock:(AnyObject)->(), hasAlreadySession:(Bool)->()){
        
        if LISDKSessionManager.hasValidSession() {
            hasAlreadySession(true)
            return
        }
        LISDKSessionManager.createSessionWithAuth([LISDK_BASIC_PROFILE_PERMISSION,LISDK_W_SHARE_PERMISSION], state: nil, showGoToAppStoreDialog: true, successBlock: { (response) in
            successBlock(response)
        }) { (error) in
            failureBlock(error)
        }
        
    }
    
    /*
     *	@functionName	: postTextMessage
     *  Description : This method is used to get user profile
     * */
    
    class func linkedInUserProfile(successBlock:(AnyObject)->(),failureBlock:(AnyObject)->()){
        
        let url = "https://api.linkedin.com/v1/people/~"
        if LISDKSessionManager.hasValidSession() {
            
            LISDKAPIHelper.sharedInstance().getRequest(url, success: { (response) in
                let dataStr = response.data
                successBlock(dataStr)
                
                }, error: { (error) in
                    failureBlock(error)
            })
        }else{
            failureBlock("Invalid Session")
        }
        
    }
    
    /*
     *	@functionName	: shareOnLinkedin
     *  description: This method is can be used to share on Linkedin
     * */
    
    class func shareOnLinkedin(comment:[String:String],visbilityArray:[String:String],success:(AnyObject)->(), failure:(AnyObject)->()){
        
        let url = "https://api.linkedin.com/v1/people/~/shares"
        let comment = comment
        let visiblityArray = visbilityArray
        let visibility = ["visibility":visiblityArray]
        
        let shareMessage:NSMutableDictionary = NSMutableDictionary()
        shareMessage.addEntriesFromDictionary(comment)
        shareMessage.addEntriesFromDictionary(visibility)
        
        do {
            
            let theJSONData = try NSJSONSerialization.dataWithJSONObject(shareMessage, options: NSJSONWritingOptions(rawValue: 1))
            let payload = String(data: theJSONData,
                                 encoding: NSUTF8StringEncoding)
            
            if LISDKSessionManager.hasValidSession() {
                
                LISDKAPIHelper.sharedInstance().postRequest(url, stringBody: payload!, success: { (response) in
                    success(response)
                    
                    }, error: { (error) in
                        failure(error)
                        
                })
            }
            else{
                failure("Invalid Session")
            }
            
        } catch {}
        
    }
    
    /*
     *	@functionName	: linkedinLogOut
     *  Description: This method can be used to logout from Linkedin
     
     * */
    
    class func linkedinLogOut(success:(Bool)->()){
        
        let cookieJar : NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in cookieJar.cookies! as [NSHTTPCookie]{
            NSLog("cookie.domain = %@", cookie.domain)
            
            if cookie.domain == "www.Linkedin.com" ||
                cookie.domain == "api.Linkedine.com"{
                
                cookieJar.deleteCookie(cookie)
            }
        }
        LISDKSessionManager.clearSession()
        
        if  !LISDKSessionManager.hasValidSession() {
            success(true)
        } else {
            success(false)
        }
    }
}


