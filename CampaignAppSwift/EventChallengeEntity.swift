//
//  EventChallengeEntity.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 28/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit

class EventChallengeEntity {
    var eventImageVidUrl: String = ""
    var isVid: Bool = false
    var updateId: String = ""
    var isAttended: Bool = false
    var challengeTitle = ""
    var challengeDesc = ""
    var challengeVidUrl = ""
    var ChallengeVidUrl: String {
        get{
            return challengeVidUrl
        }
        set{
            challengeVidUrl = newValue
        }
        
    }
    var ChallengeTitle: String {
        get{
            return challengeTitle
        }
        set{
            challengeTitle = newValue
        }
        
    }
    var ChallengeDesc: String {
        get{
            return challengeDesc
        }
        set{
            challengeDesc = newValue
        }
        
    }
    
    var EventImageVidUrl: String {
        get{
            return eventImageVidUrl
        }
        set{
            eventImageVidUrl = newValue
        }
        
    }
    var IsVid: Bool {
        get{
            return isVid
        }
        set{
            isVid = newValue
        }
        
    }
    var IsAttended: Bool {
        get{
            return isAttended
        }
        set{
            isAttended = newValue
        }
        
    }
    var UpdateId: String {
        get{
            return updateId
        }
        set{
            updateId = newValue
        }
        
    }
    
    
}
