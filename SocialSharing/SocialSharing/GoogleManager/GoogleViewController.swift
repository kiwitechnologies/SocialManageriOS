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

class GoogleViewController: UIViewController, GIDSignInDelegate,GIDSignInUIDelegate, SFSafariViewControllerDelegate {
    
    /* -------------------------------------------------------------------------------------------
     * A class is written to use the differnt features of Goole services
     * eg. Google Sign-in, Google Sharing, Google LogOut, Google Calendar
     * It helps to Reduce the line of code in entire application to integrate facbook for using mention features.
     * —————————————————————————————————————————————-----------------------------------------------*/

    @IBOutlet weak var gitSignInButton: GIDSignInButton!
    
    let kKeychainItemName = "Google Calendar API"
    let kClientID = "54698701220-h9l3pgvu7rt8akcbgs0sbl9pbmraqhnf.apps.googleusercontent.com"
    let output = UITextView()
    let scopes = [kGTLAuthScopeCalendarReadonly]
    let service = GTLServiceCalendar()
    var shareURL:String!
    
    var ggleOptions:GoogleOptions!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = kClientID
        
        switch ggleOptions! {
            
        case .GOOGLE_LOGIN:
            break
            
        case .GoogleLogOut:
            googleLogOut()
            
            
        case .GoogleSharing:
            googleSharing(shareURL)
            
            
        case .GoogleCalendar:
            googleCalendar()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
         if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            print("UserID : \(userId) \n idToken: \(idToken) \n FullName: \(fullName) \n GivenName: \(givenName) \n FamilyName: \(familyName) \n Email: \(email)")
            
            self.navigationController?.popViewControllerAnimated(true)
            
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
    
    // MARK: Google Sharing
    func googleSharing(shareURL:String) {
        
        if #available(iOS 9.0, *) {
            
            let shareURL:NSURL = NSURL(string: shareURL)!
            
            let urlComponents:NSURLComponents =  NSURLComponents(string:"https://plus.google.com/share")!
            urlComponents.queryItems = [NSURLQueryItem(name: "url", value: shareURL.absoluteString)]
            let url = urlComponents.URL
            
            
            let safariView = SFSafariViewController(URL: url!, entersReaderIfAvailable: true)
            safariView.delegate = self
            self.navigationController?.presentViewController(safariView, animated: true, completion: {
                print("Loaded")
            })
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: Google Calendar
    func googleCalendar(){
        
        output.frame = view.bounds
        output.editable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        view.addSubview(output);
        
        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(
            kKeychainItemName,
            clientID: kClientID,
            clientSecret: nil) {
            service.authorizer = auth
        }
        
        if let authorizer = service.authorizer,
            canAuth = authorizer.canAuthorize where canAuth {
            fetchEvents()
        } else {
            presentViewController(
                createAuthController(),
                animated: true,
                completion: nil
            )
        }

    }
    
    //
    // Construct a query and get a list of upcoming events from the user calendar
    func fetchEvents() {
        let query = GTLQueryCalendar.queryForEventsListWithCalendarId("primary")
        query.maxResults = 10
        query.timeMin = GTLDateTime(date: NSDate(), timeZone: NSTimeZone.localTimeZone())
        query.singleEvents = true
        query.orderBy = kGTLCalendarOrderByStartTime
        service.executeQuery(
            query,
            delegate: self,
            didFinishSelector: #selector(GoogleViewController.displayResultWithTicket(_:finishedWithObject:error:))
        )
    }
    
    // Display the start dates and event summaries in the UITextView
    func displayResultWithTicket(
        ticket: GTLServiceTicket,
        finishedWithObject response : GTLCalendarEvents,
                           error : NSError?) {
        
        if let error = error {
            showAlert("Error", message: error.localizedDescription)
            return
        }
        
        var eventString = ""
        
        if let events = response.items() where !events.isEmpty {
            for event in events as! [GTLCalendarEvent] {
                let start : GTLDateTime! = event.start.dateTime ?? event.start.date
                let startString = NSDateFormatter.localizedStringFromDate(
                    start.date,
                    dateStyle: .ShortStyle,
                    timeStyle: .ShortStyle
                )
                eventString += "\(startString) - \(event.summary)\n"
            }
        } else {
            eventString = "No upcoming events found."
        }
        
        output.text = eventString
    }
    // Creates the auth controller for authorizing access to Google Calendar API
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        let scopeString = scopes.joinWithSeparator(" ")
        return GTMOAuth2ViewControllerTouch(
            scope: scopeString,
            clientID: kClientID,
            clientSecret: nil,
            keychainItemName: kKeychainItemName,
            delegate: self,
            finishedSelector: #selector(GoogleViewController.viewController(_:finishedWithAuth:error:))
        )
    }
    
    // Handle completion of the authorization process, and update the Google Calendar API
    // with the new credentials.
    func viewController(vc : UIViewController,
                        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
        
        if let error = error {
            service.authorizer = nil
            showAlert("Authentication Error", message: error.localizedDescription)
            return
        }
        
        service.authorizer = authResult
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil
        )
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }

    //MARK: Google LogOut
    
    func googleLogOut(){
        
        GIDSignIn.sharedInstance().signOut()
    }
    
    @available(iOS 9.0, *)
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        
    }
}
