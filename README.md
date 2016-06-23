Social Sharing-Framework
=============
## Features
1. Facebook ( Login, getProfile, Text sharing, Image sharing, Linked Content Sharing, getFriend, Invite Friend, Logout ).
2. Twitter ( Login, GetProfile, Publish Post, Get user tweets, Logout).
3. Instagram (Login, getProfile, share image, user profile, logout).
4. LinkedIn (Login, Get Profile, Get Profile Additional info, Share Content, Logout).
5. Google (Login, Google Sharing, Logout).
6. Google Calendar (Login, Get Callendars).

Getting started
----------------
- The SocialSharing  Folder contains TSGSocialSharing project. This example  project contains the sample code for facebook integration, twitter integration, Instagram Integration,Google sign and Linkeding integration.
- To use the Sharing module in your application, open the Example project and copy the coresponding manager (eg. TSGFacebookManager etc) in your project.
- Configure the related social sharing in your project.

Strategy configuration
======================

FACEBOOK
--------
1. Create a application on facebook (if not exist), https://developers.facebook.com/quickstarts/?platform=android
2. Go through with below url and set up your application with provided instructions
https://developers.facebook.com/docs/android/getting-started/
3. Copy "TSGFacebookManger.swift" file into your project.
6. Starting with TSGFacebookManager.sharedInstance.loginWithPersmissions function, you can use any required function of TSGFacebookManager class.
7. Go throw with the sample code of TSGFacebookManager.swift.


TWITTER
--------
1. Install Fabric plugin in iOS Studio (if not exist).
2. Create new app of twitter using Fabric plugin.
3. Follow the instruction for configure twitter in your project using fabric. - - https://www.youtube.com/watch?v=X9qvO0DIsdk
- http://code.tutsplus.com/tutorials/quick-tip-authentication-with-twitter-and-fabric--cms-23801
4. Start with calling Twitter login class function in your class and then you can use other given features in TSGTwitterManager

INSTAGRAM
--------
1. Sharing of video and image can be done using TSGInstagramManager without the need of application credetential but Instagram application is required in iOS mobile.
1. Register your application and get ClientId, ClientSecret and Redirect_url at "https://www.instagram.com/developer/".
2. Replace the clientID and redirectURL with your clientID and redirictURL.
3. Instgaram Login is shown by separate Class i.e. InstagramLogin.Swift.You can register xib with this class and add UIWebView in your nib and connect it with webView outlet which is used in this class.
4. All other instagram feature are given in TSGInstagramManager
6. Gothrow with the sample code of TSGInstagramManager.swift class.

LINKEDIN
--------

1. Register your application at https://www.linkedin.com/developer/apps/new (It not exist)
2. Download and add LinkedIn SDK module in your project and add its dependency.
3. Starting with linkedINLogin class function,
4. Go throw with the sample code of TSGLinkedInManager.swift class to understand how other features can be used.


GOOGLE
------
1. Register your application at https://developers.google.com/mobile/add?platform=iOS
2. Setup your project by using following instructions https://developers.google.com/identity/sign-in/ios/start-integrating
3. There is GoogleViewController class which shows how to do login, logout, sharing (ios9.0) and calender in your app.


License
---------
Social Sharing Framework is KiwiTechnolgies Licensed  
Copyright © 2016