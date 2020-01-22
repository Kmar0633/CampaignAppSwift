//
//  EventChallengesViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 21/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit

class EventChallengesViewController: UIViewController {
   
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    var eventName = ""
    var eventImageUrl = ""
    var value = "es"
    @IBOutlet weak var eventDescripLabel: UILabel!
    var eventDescrip = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventNameLabel.text = self.eventName
        let url = URL(string: self.eventImageUrl)
        self.eventImage.load(url: url!)
        self.eventDescripLabel.text=self.eventDescrip
        self.eventDescripLabel.numberOfLines=8
        print(eventImageUrl)
        // Do any additional setup after loading the view.
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
