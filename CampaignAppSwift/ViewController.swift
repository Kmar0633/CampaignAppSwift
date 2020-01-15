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
    @IBOutlet weak var Name: UILabel!
    
    var refProfile: FirebaseApp!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        ref = Database.database().reference()
        let collid = ref.child("profile").child("1000117052")

        collid.observeSingleEvent(of : .value, with : {(Snapshot) in
            
            for child in Snapshot.children{
                self.Name.text=child as? String
                print(child)
                
            }
            })
}

}
