//
//  ViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 15/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit
import Firebase
import UICircularProgressRing
class ViewController: UIViewController {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
   
    @IBOutlet weak var ring: UICircularProgressRing!
    @IBOutlet weak var descriptor: UILabel!
    @IBOutlet weak var events: UILabel!

    var refProfile: FirebaseApp!
    var ref: DatabaseReference!
    var url="https://campaigndata-campaign.appspot.com/?t=upd&w=500&crop=true&file="
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        self.ring.value = 0
        // Change any of the properties you'd like
       //  let progressRing = UICircularProgressRing()
        ref = Database.database().reference()
        let collid = ref.child("profile").child("1000116942")
        let profEventChallenges=ref.child("eventchallengeslist")
        collid.observeSingleEvent(of : .value, with : {(Snapshot) in
            let value = Snapshot.value as? NSDictionary
            let username = value?["firstname"] as? String ?? ""
            let descriptionfinal=value?["descrip"] as? String ?? ""
            let imageUrl=value?["avatar"] as? String ?? ""
            self.Name.text=username
            self.Name.numberOfLines=6

    self.descriptor.text=descriptionfinal
      
            let urlImage=URL(string:self.url+imageUrl)
            self.image.load(url: urlImage!)
            })
        
        profEventChallenges.observeSingleEvent(of : .value, with : {(Snapshot) in
            for case let rest as DataSnapshot in Snapshot.children {
               print(rest.value)
            }
                })
        
        
}
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0){
            self.ring.value = 60
        }
    }
  
}


extension UIImageView {
      func load(url: URL) {
          DispatchQueue.global().async { [weak self] in
              if let data = try? Data(contentsOf: url) {
                  if let image = UIImage(data: data) {
                      DispatchQueue.main.async {
                          self?.image = image
                      }
                  }
              }
          }
      }
    }
