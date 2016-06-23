//
//  TSGInstagramManager.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 21/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import TSGServiceClient

class TSGInstagramManager:NSObject {
    
    var success:(status:Bool)->()? = {_ in return}
    
    internal class var sharedInstance:TSGInstagramManager{
        struct Static{
            static var onceToken: dispatch_once_t = 0
            static var instance: TSGInstagramManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TSGInstagramManager()
        }
        return Static.instance!
    }
    
    
    /*
     *	@functionName	: instagramPostImage
     *  description: This method is used to post image in Instagram app.
     * */
    
    func instagramPostImage(view:UIView,image:UIImage, success:(status:Bool)->()){
        let url = NSURL(string: "instagram://")
        
        self.success = success
        
        if UIApplication.sharedApplication().canOpenURL(url!) {
            NSDataWritingOptions.AtomicWrite
            
            let image = image
            let imageData = UIImageJPEGRepresentation(image, 1.0)
            
            
            let temporaryDirectory = NSTemporaryDirectory() as NSString
            let temporaryImagePath = temporaryDirectory.stringByAppendingPathComponent("instag.igo")
            
            let boolValue = imageData!.writeToFile(temporaryImagePath, atomically: true)
            
            print(boolValue)
            docFile = UIDocumentInteractionController()
            docFile!.delegate = self
            docFile!.URL = NSURL.fileURLWithPath(temporaryImagePath)
            print(docFile!.URL)
            // docFile?.annotation = NSDictionary
            docFile!.UTI = "com.instagram.exclusivegram"
            docFile!.presentOpenInMenuFromRect(
                view.bounds,
                inView: view,
                animated: true
            )
            
        }
    }
    
    /*
     *	@functionName	: instagramUserProfile
     *  description: This method is used to get UserProfile
     * */
    
    func instagramUserProfile(successBlock:(AnyObject)->(), failureBlock:(AnyObject)->()){
        
        if let token = NSUserDefaults().valueForKey("Instagram_Token") {
            
            let queryParam = ["access_token":token as! String]
            ServiceManager.setBaseURL("https://api.instagram.com/v1/")
            ServiceManager.hitRequestForAPI("users/self/", withQueryParam: queryParam, typeOfRequest: .GET, typeOFResponse: .JSON, success: { (object) in
                print(object)
            }) { (error) in
                print(error)
            }
        }else{
            failureBlock("Token Not found")
 
        }
    }
    
    /*
     *	@functionName	: instagramUserProfile
     *  description: This method is used to get friendProfile based on ID
     * */
    func instagramFriendProfile(userID:String, successBlock:(AnyObject)->(),failureBlock:(AnyObject)->()){
        
        if let token = NSUserDefaults().valueForKey("Instagram_Token") {
            let queryParam = ["access_token":token as! String]
            
            ServiceManager.setBaseURL("https://api.instagram.com/v1/")
            ServiceManager.hitRequestForAPI("users/\(userID)", withQueryParam: queryParam, typeOfRequest: .GET, typeOFResponse: .JSON, success: { (object) in
                print(object)
            }) { (error) in
                print(error)
            }
        }
        else {
            failureBlock("Token Not found")
  
        }
    }
    
    /*
     *	@functionName	: instagramLogOut
     *  description: This method is used to logOut from Instagram
     * */
    
    func instagramLogOut(success:(status:Bool)->()){
        
        let cookieJar : NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in cookieJar.cookies! as [NSHTTPCookie]{
            NSLog("cookie.domain = %@", cookie.domain)
            
            if cookie.domain == "www.instagram.com" ||
                cookie.domain == "api.instagram.com"{
                
                cookieJar.deleteCookie(cookie)
            }
        }
        NSUserDefaults().removeObjectForKey("Instagram_Token")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        success(status: true)
    }
}

extension TSGInstagramManager: UIDocumentInteractionControllerDelegate{
    func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        success(status: true)
    }
    func documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController) {
        success(status: false)
    }
}