//
//  TSGSocialHelper-Extension(Facebook).swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 03/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

/* -------------------------------------------------------------------------------------------
 * A class is written to use the differnt features of Facebook sdk and GraphAPI
 * eg. Facebook login, Invite Friends, Get User Data, Post etc
 * It helps to Reduce the line of code in entire application to integrate facbook for using mention features.
 * —————————————————————————————————————————————-----------------------------------------------*/

import Foundation
import FBSDKLoginKit
import FBSDKShareKit


class TSGFacebookManager:NSObject, FBSDKSharingDelegate, FBSDKAppInviteDialogDelegate {
    
    var successBlock:(response:AnyObject)->()? = {_ in return}
    var failureBlock:(response:AnyObject)->()? = {_ in return}
    var cancelBlock:(response:AnyObject)->()? = {_ in return}
    var invitationMade:(status:Bool)->() = {_ in return}
    
    internal class var sharedInstance:TSGFacebookManager{
        struct Static{
            static var onceToken: dispatch_once_t = 0
            static var instance: TSGFacebookManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = TSGFacebookManager()
        }
        return Static.instance!
    }
    
    /*
     *	@functionName	: loginWithPersmissions
     *	@parameters		: permissions : It would have the permissions array
     *                  : success : Its a success block
     *                  : cancelled : Its a cancelled block
     *                  : failure : Its a failure block
     *                  :
     * */
    
    func loginWithPersmissions( permissions:NSArray,success:(token:String) -> Void,cancelled:()-> Void,failure:(NSError) -> Void)
    {
        var loginManager:FBSDKLoginManager!
        loginManager = FBSDKLoginManager()
        
        loginManager.loginBehavior = FBSDKLoginBehavior.SystemAccount
        
        loginManager.logInWithReadPermissions(permissions as [AnyObject], fromViewController: nil, handler: { (result, error) -> Void in
            if ((error) != nil)
            {
                failure(error)
            }
            else if result.isCancelled {
                cancelled()
            }
            else
            {
                success(token: FBSDKAccessToken.currentAccessToken().tokenString)
            }
        })
    }
    
    /*
     *	@functionName	: getUserData
     *	@parameters		: fields : Its a field array
     *                  : success : Its a success block
     *                  : failure : Its a failure block
     *                  :
     * */
    
    func getUserData( fields:[NSObject : AnyObject],success:(AnyObject) -> Void,failure:(NSError) -> Void)
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: fields)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil)
            {
                print(error)
                
                failure(error)
            }
            else
            {
                print(result)
                
                success(result)
            }
        })
    }
    
    /*
     *	@functionName	: postTextMessage
     *	@parameters		: viewController : It needs viewController on which Dialog has to show
     *                  : contentTitle : It requires contentTitle
     
     * */
    
    func postTextMessage(viewController:UIViewController, contentTitle:String){
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            
            
            let shareLinkContent = FBSDKShareLinkContent()
            //  shareLinkContent.contentURL = NSURL(string: "https://developers.facebook.com")
            shareLinkContent.contentTitle = contentTitle
            
            
            FBSDKMessageDialog.showWithContent(shareLinkContent, delegate: nil)
        }
    }
    
    /*
     *	@functionName	: postTextWithImageInBackground
     *	@parameters		: viewController : It needs viewController on which Dialog has to show
     *                  : caption : It requires caption
     *                  : imageName : Its requires imageName
     
     
     * */
    
    func postTextWithImageInBackground(viewController:UIViewController, caption:String, imageName:String, successBlock:(response:AnyObject)->(), failureBlock:(error:AnyObject)->(), cancelBlock:(message:AnyObject)->()){
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            if FBSDKAccessToken.currentAccessToken().hasGranted("publish_actions") {
                let sharePhoto = FBSDKSharePhoto()
                sharePhoto.caption = caption
                sharePhoto.image = UIImage(named: imageName)
                
                let content = FBSDKSharePhotoContent()
                content.photos = [sharePhoto]
                self.successBlock = successBlock
                self.failureBlock  = failureBlock
                self.cancelBlock = cancelBlock
                FBSDKShareAPI.shareWithContent(content, delegate: self)
            } else{
                let loginManager = FBSDKLoginManager()
                loginManager.logInWithPublishPermissions(["publish_actions"], fromViewController: viewController, handler: { (result, error) in
                    print(result)
                })
                
            }
        }
        
    }
    
    /*
     *	@functionName	: postImageAndText
     *	@parameters		: viewController : It needs viewController on which Dialog has to show
     *                  : caption : It requires caption
     *                  : imageName : Its requires imageName
     
     * */
    
    func postImageAndText(viewController:UIViewController, caption:String, imageName:String, successBlock:(response:AnyObject)->()?,
                          failureBlock:(response:AnyObject)->()?, cancelBlock:(response:AnyObject)->()?){
        
        let sharePhoto = FBSDKSharePhoto()
        sharePhoto.caption = caption
        sharePhoto.image = UIImage(named:imageName)
        
        let content = FBSDKSharePhotoContent()
        content.photos = [sharePhoto]
        self.successBlock = successBlock
        self.failureBlock = failureBlock
        self.cancelBlock = cancelBlock
        
        FBSDKShareDialog.showFromViewController(viewController, withContent: content, delegate: self)
    }
    
    /*
     *	@functionName	: postLink
     *	@parameters		: viewController : It needs viewController on which Dialog has to show
     *                  : contentURL : It requires content URL
     *                  : contentTitle : Its requires contentTitle
     
     * */
    
    func postLink(viewController:UIViewController, contentURL:String, contentTitle:String, successBlock:(response:AnyObject)->(), failureBlock:(failure:AnyObject)->(), cancel:(msg:AnyObject)->()){
        
        
        let shareLinkContent = FBSDKShareLinkContent()
        shareLinkContent.contentURL = NSURL(string: contentURL)
        shareLinkContent.contentTitle = contentTitle
        self.successBlock = successBlock
        self.failureBlock = failureBlock
        self.cancelBlock = cancel
        FBSDKShareDialog.showFromViewController(viewController, withContent: shareLinkContent, delegate: self)
    }
    
    /*
     *	@functionName	: postLinkInBackground
     *	@parameters		: contentURL : It requires content URL
     *                  : contentTitle : Its requires contentTitle
     
     * */
    func postLinkInBackground(viewController:UIViewController, contentURL:String, contentTitle:String, successBlock:(response:AnyObject)->(),
                              failureBlock:(failure:AnyObject)->(), cancel:(msg:AnyObject)->()){
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            if FBSDKAccessToken.currentAccessToken().hasGranted("publish_actions") {
                let shareLinkContent = FBSDKShareLinkContent()
                shareLinkContent.contentURL = NSURL(string: contentURL)
                shareLinkContent.contentTitle = contentTitle
                self.successBlock = successBlock
                self.failureBlock = failureBlock
                self.cancelBlock = cancel
                
                FBSDKShareAPI.shareWithContent(shareLinkContent, delegate: nil)
            }
            else {
                let loginManager = FBSDKLoginManager()
                loginManager.logInWithPublishPermissions(["publish_actions"], fromViewController: viewController, handler: { (result, error) in
                    print(result)
                })
            }
        }
        
    }
    
    /*
     *	@functionName	: facebookLogOut
     * */
    func facebookLogOut(status:(Bool)->()){
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            FBSDKAccessToken.setCurrentAccessToken(nil)
            FBSDKProfile.setCurrentProfile(nil)
            let manager = FBSDKLoginManager()
            manager.logOut()
            print("LogOut successfully")
            status(true)
            
        }
    }
    
    /*
     *	@functionName	: getFriendList
     
     * */
    
    func getFriendList(successBlock:(AnyObject)->(), failureBlock:(AnyObject)->()){
        
        if FBSDKAccessToken.currentAccessToken().hasGranted("user_friends") {
            
            self.successBlock = successBlock
            self.failureBlock = failureBlock
            
            let postText:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters:nil, HTTPMethod: "GET")
            postText.startWithCompletionHandler({ (requestConnection, object, error) in
                
                self.successBlock(response: object)
                self.failureBlock(response: error)
                
            })
        }
    }
    
    /*
     *	@functionName	: appInvite
     *	@parameters		: appLinkURL : It requires app link url string
     *                  : previewImageURL : Its requires Image url string
     * */
    
    func appInvite(viewController:UIViewController, appLinkURL:String, previewImageURL:String, successBlock:(AnyObject)->(), failureBlock:(AnyObject)->()){
        
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        
        self.successBlock = successBlock
        self.failureBlock = failureBlock
        
        if(inviteDialog.canShow()){
            
            let appLinkUrl:NSURL = NSURL(string: appLinkURL)!
            
            let previewImageUrl:NSURL = NSURL(string: previewImageURL)!
            
            let inviteContent:FBSDKAppInviteContent = FBSDKAppInviteContent()
            inviteContent.appInvitePreviewImageURL = previewImageUrl
            inviteContent.appLinkURL = appLinkUrl
            inviteDialog.content = inviteContent
            inviteDialog.delegate = self
            inviteDialog.show()
        }
    }
    
}

//MARK: FBSDKSharingDelegates
extension TSGFacebookManager {
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        successBlock(response: results)
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        failureBlock(response: error)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        cancelBlock(response: "Request Cancelled")
    }
    
}

//MARK: FBSDKAppInviteDialogDelegate
extension TSGFacebookManager {
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        invitationMade(status: true)
    }
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        invitationMade(status: false)
        
    }
    
}
