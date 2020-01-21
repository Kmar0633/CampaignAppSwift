//
//  EventChallengesViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 21/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit

class EventChallengesViewController: UIViewController {
    var test = ""
    var value = "es"
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        print()
        print(self.test)
        // Do any additional setup after loading the view.
    }
    

    func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if(identifier == "profEventsToEventChallenges"){
           // segue_identifier is the viewController and storyBoard Reference segue identifier.
            print("hello")
            print(self.test)
        }
        return true;
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
