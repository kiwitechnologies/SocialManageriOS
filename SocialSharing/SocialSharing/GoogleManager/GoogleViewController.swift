//
//  GoogleViewController.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 12/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import SafariServices
import GoogleAPIClient
import GTMOAuth2

let kGoogleClientID = "54698701220-h9l3pgvu7rt8akcbgs0sbl9pbmraqhnf.apps.googleusercontent.com"

class GoogleViewController: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate, SFSafariViewControllerDelegate {
    
    /* -------------------------------------------------------------------------------------------
     * A class is written to use the differnt features of Goole services
     * eg. Google Sign-in, Google Sharing, Google LogOut, Google Calendar
     * It helps to Reduce the line of code in entire application to integrate facbook for using mention features.
     * —————————————————————————————————————————————-----------------------------------------------*/
    
    @IBOutlet weak var gitSignInButton: GIDSignInButton!
    
    
    var ggleOptions:GoogleOptions!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = kGoogleClientID
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
    
    @IBAction func googleLogOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
  
    }
    
}
