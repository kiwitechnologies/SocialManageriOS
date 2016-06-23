//
//  PersistentDataManager.swift
//  SocialSharing
//
//  Created by Yogesh Bhatt on 02/06/16.
//  Copyright © 2016 kiwitech. All rights reserved.
//

import UIKit

class PersistentDataManager: NSObject {

   static var socialListDictionary = ["FACEBOOK":["Login","Get Profile","Post text message in background",
                                                "Post image and text message in background","Post Image and Text","Post Text Message",
                                                "Post linked content","Post linked content in background","Get Friend",
                                                "Invite Friend","Logout"],
                                    "INSTAGRAM":["Login","Get User Profile","Get Friend's Profile","Get PublishedMedia","Logout"],
                                    "TWITTER":["Login","Get Profile","Publish Post","Get All Post","Logout"],
                                    "LINKEDIN":["Login","Get Profile","Publish Post","Logout"],
                                    "GOOGLE":["Google-Login","Logout"]
    ]
}
