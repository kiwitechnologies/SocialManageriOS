//
//  SocialSharing-Extension.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 02/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation
import UIKit
import Google

extension SocialFeatures {
    
    func getFBFeature(index:Int, viewController:UIViewController){
        switch index {
            
        case 0:
            facebookLogin()
            
        case 1:
            getProfile()
            
        case 2:
            postTextMessageInBackGround()
            
        case 3:
            postImageAndTextInBackGround()
            
        case 4:
            postImageAndText(viewController)
            
        case 5:
            postLinkedContent()
            
        case 6:
            postLinkedContentInBackground()
            
        case 7:
            getFriend()
            
        case 8:
            inviteFriend()
            break
            
        case 9:
            logOut()
            
        default:
            break
        }
    }
    
    //Mark: Facebook login
    func facebookLogin(){
    
        
        let permissionArray = ["public_profile","email","user_friends"]
        
        TSGFacebookManager.sharedInstance.loginWithPersmissions(permissionArray, success: {
            print("Facebook Login Successful")
            }, cancelled: { 
                print("Facebook Login Cancelled")

            }, failure: {_ in
                print("Facebook Login failure")

            }
        )
    }
    
    //Mark: Facebook Get User Profile

    func getProfile(){
        
        TSGFacebookManager.sharedInstance.getUserData(["fields":"name,id,gender,email,picture.type(large)"], success: { (object) in
            print(object)
            }) { (error) in
                
        }
    }
    
    //Mark: Facebook Post text message in Background

    func postTextMessageInBackGround(){

        TSGFacebookManager.sharedInstance.postTextMessage(self, contentTitle: "TSG Message Testing")
    }
    
    //Mark: Facebook Post image and text in Background

    func postImageAndTextInBackGround(){
     
        TSGFacebookManager.sharedInstance.postTextWithImageInBackground(self, caption: "TSG Post Text and Image", imageName: "abc.png")

    }
    
    //Mark: Facebook Post image and text

    func postImageAndText(viewController:UIViewController){
        TSGFacebookManager.sharedInstance.postImageAndText(self, caption: "TSG Post Text and Image", imageName: "abc.png")
    }
    
    //Mark: Facebook Post Link

    func postLinkedContent(){
        
        TSGFacebookManager.sharedInstance.postLink(self, contentURL: "https://developers.facebook.com", contentTitle: "TSG Link Share Testing")
    }
    
    //Mark: Facebook Post Link

    func postLinkedContentInBackground(){
        
        TSGFacebookManager.sharedInstance.postLinkInBackground(self, contentURL: "https://developers.facebook.com", contentTitle: "TSG Link Share Testing")
        
    }
    
    func getFriend(){
        TSGFacebookManager.sharedInstance.getFriendList()
    }
    
    func inviteFriend(){
        TSGFacebookManager.sharedInstance.appInvite(self, appLinkURL: "https://fb.me/1241148712577097", previewImageURL: "")
    }
    
    func logOut(){
        TSGFacebookManager.sharedInstance.facebookLogOut()
    }

    
}