//
//  Enum.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 02/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import Foundation

public enum GoogleOptions:Int {
    case GOOGLE_LOGIN
    case GoogleSharing
    case GoogleCalendar
    case GoogleLogOut
}

public enum InstagramOptions:Int {
    case INSTAGRAM_LOGIN
    case INSTAGRAM_USER_PROFILE
    case INSTAGRAM_FRIEND_PROFILE
    case INSTAGRAM_PUBLISH_POST
    case INSTAGRAM_PUBLISH_MEDIA
    case INSTAGRAM_POST_IMAGE
    case INSTAGRAM_LOG_OUT
}

public enum SocialPlatformName:String {
    
    case FACEBOOK
    case TWITTER
    case INSTAGRAM
    case LINKEDIN
    case GOOGLE
    
}

public enum LinkedinOptions:Int {
    
    case LINKEDIN_LOGIN
    case LINKEDIN_USER_PROFILE
    case LINKEDIN_SHARE
    case LINKEDIN_LOGOUT
    
}
