//
//  ChallengeActionEntity.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 30/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit

class ChallengeActionEntity {
var actionTitle = ""
    var actionImageUrl = ""
    var actionDesc = ""
    
    var ActionTitle: String {
        get{
            return actionTitle
        }
        set{
            actionTitle = newValue
        }
        
    }
    
    var ActionImageUrl: String {
        get{
            return actionImageUrl
        }
        set{
            actionImageUrl = newValue
        }
        
    }
    
    var ActionDesc: String {
           get{
               return actionDesc
           }
           set{
               actionDesc = newValue
           }
           
       }

}
