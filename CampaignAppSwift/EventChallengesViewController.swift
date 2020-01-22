//
//  EventChallengesViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 21/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit
import Firebase
class EventChallengesViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    
   
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    var eventName = ""
    @IBOutlet weak var challengesCollectionView: UICollectionView!
    var eventChallengeImageVidUrls: [String] = []
    var eventChallengesIds = [String]()
    var challengeTitles: [String] = []
    var challengeDescrips: [String] = []
    var challengePicts: [String] = []
    var challengeImgVidUrl = "https://campaigndata-campaign.appspot.com/?t=upd&w=500&crop=true&file="
    var eventImageUrl = ""
    var value = "es"
    @IBOutlet weak var eventDescripLabel: UILabel!
    var eventDescrip = ""
    var eventId = ""
  var refProfile: FirebaseApp!
       var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventNameLabel.text = self.eventName
     //   FirebaseApp.configure()
        ref = Database.database().reference()
        let eventChallengesList=ref.child("eventchallengeslist").child(self.eventId)
        let updates=ref.child("updates")
        
        
        let url = URL(string: self.eventImageUrl)
        self.eventImage.load(url: url!)
        self.eventDescripLabel.text=self.eventDescrip
        print(self.eventDescrip)
        self.eventDescripLabel.numberOfLines=8
//        self.challengesCollectionView.delegate=self
  //      self.challengesCollectionView.dataSource=self
        eventChallengesList.observeSingleEvent(of : .value, with : {(Snapshot) in
        let eventChallengesListDict = Snapshot.value as? [String : AnyObject] ?? [:]
            for (key,value) in eventChallengesListDict{
                self.eventChallengesIds.append(key)
               
            }
           
            updates.observeSingleEvent(of: .value) { (DataSnapshot) in
                let update = DataSnapshot.value as? [String : AnyObject] ?? [:]
                for (key,value) in update{
                    if self.eventChallengesIds.contains(key){
                        updates.child(key).observeSingleEvent(of:  .value) { (DataSnapshot) in
                             let value2 = DataSnapshot.value as? NSDictionary
                            let challengePict = value2?["pict"] as? String ?? ""
                            updates.child(key).child("pict").child("pict1").observeSingleEvent(of: .value) { (DataSnapshot) in
                                let pictValue = DataSnapshot.value as? NSDictionary
                                                           let challengePict = pictValue?["attfile"] as? String ?? ""
                                self.eventChallengeImageVidUrls.append(self.challengeImgVidUrl+challengePict)
                                print(challengePict)
                            }
                            
                        }
                        
                    }
                }
                
            }
                })
        
        
        // Do any additional setup after loading the view.
    }
    


 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return self.eventChallengeImageVidUrls.count
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
     
     let cell:NewChallengeCollectionViewCell = self.challengesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewChallengeCollectionViewCell
     cell.challengeTItle.text = self.eventChallengeImageVidUrls[indexPath.row]
     return cell
 }
 

}
