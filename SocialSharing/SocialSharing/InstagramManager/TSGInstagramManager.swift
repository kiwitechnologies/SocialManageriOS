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
    
    func instagramPostImage(view:UIView){
        let url = NSURL(string: "instagram://")
        
        if UIApplication.sharedApplication().canOpenURL(url!) {
            NSDataWritingOptions.AtomicWrite
            
            let image = UIImage(named: "IMG_4301.jpg", inBundle: NSBundle(forClass: self.dynamicType), compatibleWithTraitCollection: nil)
            
            let imageData = UIImageJPEGRepresentation(image!, 1.0)
            
            
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
    
    func instagramUserProfile(successBlock:(AnyObject)->(), failureBlock:(AnyObject)->()){
        
        let token = NSUserDefaults().valueForKey("Instagram_Token")
        let queryParam = ["access_token":token as! String]
        
        let tempDict:NSMutableDictionary = NSMutableDictionary()
        tempDict.setValue("3314177362", forKey: "user-id")
        
        ServiceManager.setBaseURL("https://api.instagram.com/v1/")
        ServiceManager.hitRequestForAPI("users/self/", withQueryParam: queryParam, typeOfRequest: .GET, typeOFResponse: .JSON, success: { (object) in
            print(object)
            }) { (error) in
                print(error)
        }
        
    }
    
    func instagramFriendProfile(successBlock:(AnyObject)->(),failureBlock:(AnyObject)->()){
        let token = NSUserDefaults().valueForKey("Instagram_Token")
        let queryParam = ["access_token":token as! String]
        
        let tempDict:NSMutableDictionary = NSMutableDictionary()
        tempDict.setValue("3314177362", forKey: "user-id")
        
        ServiceManager.setBaseURL("https://api.instagram.com/v1/")
        ServiceManager.hitRequestForAPI("users/3314177362", withQueryParam: queryParam, typeOfRequest: .GET, typeOFResponse: .JSON, success: { (object) in
            print(object)
            }) { (error) in
                print(error)
        }
        
    }
    
    func instagramLogOut(){
        let cookieJar : NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in cookieJar.cookies! as [NSHTTPCookie]{
            NSLog("cookie.domain = %@", cookie.domain)
            
            if cookie.domain == "www.instagram.com" ||
                cookie.domain == "api.instagram.com"{
                
                cookieJar.deleteCookie(cookie)
            }
        }
    }
    
    func instagramPublishMedia(successBlock:(AnyObject)->(),failureBlock:(AnyObject)->()){
        let token = NSUserDefaults().valueForKey("Instagram_Token")
        let queryParam = ["access_token":token as! String]
        
        ServiceManager.setBaseURL("https://api.instagram.com/v1/")
        ServiceManager.hitRequestForAPI("/users/self/media/recent/", withQueryParam: queryParam, typeOfRequest: .GET, typeOFResponse: .JSON, success: { (object) in
            print(object)
            }) { (error) in
                print(error)
        }
    }
}

extension TSGInstagramManager: UIDocumentInteractionControllerDelegate{
    func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        
    }
    func documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController) {
        
    }
}