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
    
    @IBOutlet weak var descriptor: UILabel!
    var refProfile: FirebaseApp!
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        ref = Database.database().reference()
        let collid = ref.child("profile").child("1000117052")

        collid.observeSingleEvent(of : .value, with : {(Snapshot) in
            let value = Snapshot.value as? NSDictionary
            let username = value?["firstname"] as? String ?? ""
            let descriptionfinal=value?["descrip"] as? String ?? ""
            self.Name.text=username
    self.descriptor.text=descriptionfinal
            print(descriptionfinal)
            print(username)
            })
}

}
