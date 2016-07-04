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
            
            postImageAndTextInBackGround()
            
        case 3:
            postImageAndText(viewController)
            
        case 4:
            postLinkedContent()
            
        case 5:
            postLinkedContentInBackground()
            
        case 6:
            getFriend()
            
        case 7:
            inviteFriend()
            
        case 8:
            logOut()
            
            
        default:
            break
        }
    }
    
    //Mark: Facebook login
    func facebookLogin(){
        
        
        let permissionArray = ["public_profile","email","user_friends"]
        
        TSGFacebookManager.sharedInstance.loginWithPersmissions(permissionArray, success: { token in
            print("Facebook Login Successful. Token :\(token)")
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
    
    //Mark: Facebook Post image and text in Background
    
    func postImageAndTextInBackGround()
    {
        TSGFacebookManager.sharedInstance.postTextWithImageInBackground(self, caption: "TSG Post Text and Image", imageName: "abc.png", successBlock: { (response) in
            print(response)
            }, failureBlock: { (error) in
                print(error)
        }) { (message) in
            print(message)
        }
    }
    
    //Mark: Facebook Post image and text
    
    func postImageAndText(viewController:UIViewController)
    {
        TSGFacebookManager.sharedInstance.postImageAndText(self, caption: "TSG Post Text and Image", imageName: "abc.png", successBlock: { (response) -> ()? in
            print(response)
            }, failureBlock: { (error) -> ()? in
                print(error)
        }) { (cancel) -> ()? in
            print(cancel)
        }
    }
    
    //Mark: Facebook Post Link
    
    func postLinkedContent(){
        
        TSGFacebookManager.sharedInstance.postLink(self, contentURL: "https://developers.facebook.com", contentTitle: "TSG Link SharTesting", successBlock: { (response) in
            print(response)
            }, failureBlock: { (failure) in
                print(failure)
            }, cancel: { (msg) in
                print(msg)
        })
    }
    
    //Mark: Facebook Post Link
    
    func postLinkedContentInBackground(){
        
        TSGFacebookManager.sharedInstance.postLinkInBackground(self, contentURL: "https://developers.facebook.com", contentTitle: "TSG Link Share Testing", successBlock: { (response) in
            print(response)
            }, failureBlock: { (failure) in
                print(failure)
        }) { (msg) in
            print(msg)
        }
        
    }
    
    func getFriend(){
        
        TSGFacebookManager.sharedInstance.getFriendList({ (object) in
            print(object)
        }) { (error) in
            print(error)
        }
    }
    
    func inviteFriend(){
        
        TSGFacebookManager.sharedInstance.appInvite(self, appLinkURL: "", previewImageURL: "", successBlock: { (result) in
            print(result)
        }) { (error) in
            print(error)
        }
    }
    
    func logOut(){
        TSGFacebookManager.sharedInstance.facebookLogOut { (status) in
            print(status)
        }
    }
    
    
}