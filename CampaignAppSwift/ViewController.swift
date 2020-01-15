//
//  ViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 15/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var refProfile: FirebaseApp!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
       
    }


}

