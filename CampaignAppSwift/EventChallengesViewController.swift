//
//  EventChallengesViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 21/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit
import Firebase
class EventChallengesViewController: UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var eventChallengeImageVidUrls: [String] = []
   var items: [String] = []
     var challengeImgVidUrl = "https://campaigndata-campaign.appspot.com/?t=upd&w=500&crop=true&file="
    let reuseIdentifier = "cell"
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var challengeCollectionView: UICollectionView!
    var eventName = ""
    var eventImageUrl = ""
    var value = "es"
    var eventId = ""
    @IBOutlet weak var eventDescripLabel: UILabel!
    var eventDescrip = ""
    var refProfile: FirebaseApp!
    var ref: DatabaseReference!
  
 var eventChallengesIds = [String]()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.challengeCollectionView.frame.size.width - space) / 3.0
        
        return CGSize(width: size+50, height: size+50)
        
    }


  
    override func viewDidLoad() {
        super.viewDidLoad()
     //   self.challengeCollectionView.delegate=self
       //               self.challengeCollectionView.dataSource=self
        self.eventNameLabel.text = self.eventName
        let urlEventImage = URL(string: self.eventImageUrl)
        self.eventImage.load(url: urlEventImage!)
        self.eventDescripLabel.text=self.eventDescrip
        self.eventDescripLabel.numberOfLines=8
        ref = Database.database().reference()
        print(self.eventId)
    //           let updates=ref.child("updates")
     //   print(eventChallengesList)
     //   print(updates)
        
        // Do any additional setup after loading the view.
        let eventChallengesList=ref.child("eventchallengeslist").child(self.eventId)
                let updates=ref.child("updates")
       
                let url = URL(string: self.eventImageUrl)
                self.eventImage.load(url: url!)
                self.eventDescripLabel.text=self.eventDescrip
                print(self.eventDescrip)
     
                self.eventDescripLabel.numberOfLines=8
      
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
                                        
                                        self.items.append(self.challengeImgVidUrl+challengePict)
                                        self.challengeCollectionView.reloadData()
                                        }

                                    }

                                }

                            }
                     

                        }

                         
                        })
        //self.challengeCollectionView.delegate = self
                                                      
                
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ChallengeCollectionViewCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.challengeTitle.text = self.items[indexPath.item]
        let url = URL(string: self.items[indexPath.row])
        cell.challengeImage.load(url: url!)
        //cell.backgroundColor = UIColor.cyan // make cell more visible in our example project

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
      

        self.challengeCollectionView.reloadData() // ...and it is also visible here.
    }
}
