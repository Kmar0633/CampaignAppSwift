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
    
    
}
