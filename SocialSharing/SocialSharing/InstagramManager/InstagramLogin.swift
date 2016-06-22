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
        instagramLogin()
    }
    
    func instagramLogin(){
        
        let urlString = "https://instagram.com/oauth/authorize/?client_id=5a3f5995eca74eb7b1a348615638f96e&redirect_uri=https://www.facebook.com&response_type=token&scope=basic"
            webView.loadRequest(NSURLRequest(URL: NSURL(string: urlString)!))
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