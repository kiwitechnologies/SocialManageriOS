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

    func loginWithPersmissions( permissions:NSArray,success:() -> Void,cancelled:()-> Void,failure:(NSError) -> Void)
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
                success()
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
    
    func postTextWithImageInBackground(viewController:UIViewController, caption:String, imageName:String){

        let sharePhoto = FBSDKSharePhoto()
        sharePhoto.caption = caption
        sharePhoto.image = UIImage(named: imageName)
        
        let content = FBSDKSharePhotoContent()
        content.photos = [sharePhoto]
        
        FBSDKShareAPI.shareWithContent(content, delegate: self)
        
        //  FBSDKMessageDialog.showWithContent(content, delegate: nil)
        // FBSDKShareDialog.showFromViewController(viewController, withContent: content, delegate: nil)
    }
    
    /*
     *	@functionName	: postImageAndText
     *	@parameters		: viewController : It needs viewController on which Dialog has to show
     *                  : caption : It requires caption
     *                  : imageName : Its requires imageName

     * */

    func postImageAndText(viewController:UIViewController, caption:String, imageName:String){
        
        let sharePhoto = FBSDKSharePhoto()
        sharePhoto.caption = caption
        sharePhoto.image = UIImage(named:imageName)
        
        let content = FBSDKSharePhotoContent()
        content.photos = [sharePhoto]
        
        FBSDKShareDialog.showFromViewController(viewController, withContent: content, delegate: self)
    }
    
    /*
     *	@functionName	: postLink
     *	@parameters		: viewController : It needs viewController on which Dialog has to show
     *                  : contentURL : It requires content URL
     *                  : contentTitle : Its requires contentTitle

     * */
    
    func postLink(viewController:UIViewController, contentURL:String, contentTitle:String){
        
        let shareLinkContent = FBSDKShareLinkContent()
        shareLinkContent.contentURL = NSURL(string: contentURL)
        shareLinkContent.contentTitle = contentTitle
        
        FBSDKShareDialog.showFromViewController(viewController, withContent: shareLinkContent, delegate: self)
    }
    
    /*
     *	@functionName	: postLinkInBackground
     *	@parameters		: contentURL : It requires content URL
     *                  : contentTitle : Its requires contentTitle

     * */
    func postLinkInBackground(viewController:UIViewController, contentURL:String, contentTitle:String){
        
        let shareLinkContent = FBSDKShareLinkContent()
        shareLinkContent.contentURL = NSURL(string: contentURL)
        shareLinkContent.contentTitle = contentTitle
        
        FBSDKShareAPI.shareWithContent(shareLinkContent, delegate: nil)
        
    }

    /*
     *	@functionName	: facebookLogOut
     * */
    func facebookLogOut(){
    
     if FBSDKAccessToken.currentAccessToken() != nil {
        FBSDKAccessToken.setCurrentAccessToken(nil)
        FBSDKProfile.setCurrentProfile(nil)
        
        let manager = FBSDKLoginManager()
        manager.logOut()
        print("LogOut successfully")
        
        }
    }
    
    /*
     *	@functionName	: getFriendList
     
     * */
    
    func getFriendList(){
        
        if FBSDKAccessToken.currentAccessToken().hasGranted("user_friends") {
            
        let postText:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters:nil, HTTPMethod: "GET")
            postText.startWithCompletionHandler({ (fb, any, error) in
                print(fb)
                print(any)

            })
        }
    }
    
    /*
     *	@functionName	: appInvite
     *	@parameters		: appLinkURL : It requires app link url string
     *                  : previewImageURL : Its requires Image url string
     * */
    
    func appInvite(viewController:UIViewController, appLinkURL:String, previewImageURL:String){
        
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        
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
        print(results)
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        print("sharer NSError")
        print(error.description)
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }

}

//MARK: FBSDKAppInviteDialogDelegate
extension TSGFacebookManager {
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        print("invitation made")
    }
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        print("error made")
    }

}
