//
//  InstagramViewController.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 09/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import TSGServiceClient

class InstagramViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var IMOptions:InstagramOptions!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self

        
        switch IMOptions! {
        case .INSTAGRAM_LOGIN:
            instagramLogin()

        case .INSTAGRAM_POST_IMAGE:
            instagramPostImage()
            
        case .INSTAGRAM_USER_PROFILE:
            instagramUserProfile()
            
        case .INSTAGRAM_FRIEND_PROFILE:
            instagramFriendProfile()
            
        case .INSTAGRAM_LOG_OUT:
            instagramLogOut()
            
        case .INSTAGRAM_PUBLISH_MEDIA:
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func instagramLogin(){
        
        let urlString = "https://instagram.com/oauth/authorize/?client_id=5a3f5995eca74eb7b1a348615638f96e&redirect_uri=https://www.facebook.com&response_type=token&scope=basic"
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: urlString)!))

    }
    
    func instagramPostImage(){
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
                self.view.bounds,
                inView: self.view,
                animated: true
            )
            
        }
 
    }
    
    func instagramUserProfile(){
        
        let token = NSUserDefaults().valueForKey("Instagram_Token")
        let queryParam = ["access_token":token as! String]
        
        let tempDict:NSMutableDictionary = NSMutableDictionary()
        tempDict.setValue("3314177362", forKey: "user-id")
        
        TSGServiceManager.performAction("5745591afec9101a0a63f23d", withQueryParam: queryParam, onSuccess: { (object) in
            
            print(object)
        }) { (bool, error) in
            print(error)
            
        }

    }
    
    func instagramFriendProfile(){
        let token = NSUserDefaults().valueForKey("Instagram_Token")
        let queryParam = ["access_token":token as! String]
        
        let tempDict:NSMutableDictionary = NSMutableDictionary()
        tempDict.setValue("3314177362", forKey: "user-id")
        
        TSGServiceManager.performAction("5759249a62c18b953cf00e7f", withQueryParam: queryParam, withPathParams: tempDict, onSuccess: { (object) in
            
            print(object)
        }) { (bool, error) in
            print(error)
            
        }

    }
    
    func instagramLogOut(){
        
    }
    
    func instagramPublishMedia(){
        let token = NSUserDefaults().valueForKey("Instagram_Token")
        let queryParam = ["access_token":token as! String]
        
        TSGServiceManager.performAction("5745591afec9101a0a88823d", withQueryParam: queryParam, onSuccess: { (object) in
            
            print(object)
        }) { (bool, error) in
            print(error)
            
        }

    }
}


extension InstagramViewController:UIWebViewDelegate {
    
     func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlString = request.URL?.absoluteString
        let URL = request.URL
        let urlParts = URL?.pathComponents
        
        if urlParts?.count == 1 {
            
            let nsText = urlString! as NSString
            let tokenParam = nsText.rangeOfString("access_token=")
            let token = nsText.substringFromIndex(NSMaxRange(tokenParam))
            print(token)
            if token.characters.count > 0 {
                NSUserDefaults().setString(token, forKey: "Instagram_Token")
                self.navigationController?.popViewControllerAnimated(true)
            }
        
        }
        return true
    }
    
}

extension InstagramViewController: UIDocumentInteractionControllerDelegate{
    func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        
    }
    func documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController) {
        
    }
    
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

extension NSUserDefaults {
    func setString(string:String, forKey:String) {
        setObject(string, forKey: forKey)
    }
    func setDate(date:NSDate, forKey:String) {
        setObject(date, forKey: forKey)
    }
    func dateForKey(string:String) -> NSDate? {
        return objectForKey(string) as? NSDate
    }
}