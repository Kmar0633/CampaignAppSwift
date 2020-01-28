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
    let screenHeight = UIScreen.main.bounds.height
    var scrollViewContentHeight = 1200 as CGFloat
   var eventChallengeEntities: [EventChallengeEntity] = []
     var challengeImgVidUrl = "https://campaigndata-campaign.appspot.com/?t=upd&w=500&crop=true&file="
    let reuseIdentifier = "cell"
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var challengeCollectionView: UICollectionView!
    @IBOutlet weak var eventChallengesScroller: UIScrollView!
    var eventName = ""
//    let playButtonVidIcon = #imageLiteral(resourceName: "playIcon.png")
    var eventImageUrl = ""
    var value = "es"
    var eventId = ""
    var constantEventChallengesScreenHeight = 332
  
    @IBOutlet weak var eventDescripLabel: UILabel!
    var eventDescrip = ""
    var refProfile: FirebaseApp!
    var ref: DatabaseReference!
    @IBOutlet weak var eventChallengebottomConstraint: NSLayoutConstraint!
    
 var eventChallengesIds = [String]()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.challengeCollectionView.frame.size.width - space) / 3.0
        
        return CGSize(width: size+50, height: size+50)
        
    }


  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventChallengesScroller.contentSize = CGSize(width:400, height:scrollViewContentHeight+1000)
         self.challengeCollectionView.frame.size = CGSize(width:400, height:self.challengeCollectionView.contentSize.height+10000)
self.challengeCollectionView.isScrollEnabled = false
        
        self.eventChallengesScroller.isScrollEnabled=true
        
        
     //  self. self.challengeCollectionView.delegate=self
       //               self.challengeCollectionView.dataSource=self
        
        self.eventNameLabel.text = self.eventName
        let urlEventImage = URL(string: self.eventImageUrl)
        self.eventImage.load(url: urlEventImage!)
        self.eventDescripLabel.text=self.eventDescrip
        self.eventDescripLabel.numberOfLines=8
        self.eventChallengesScroller.layoutIfNeeded()
        self.eventChallengesScroller.bounces=false
        self.challengeCollectionView.bounces=false
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
                                        let isVidValue = DataSnapshot.value as? NSDictionary
                                        let isVid = isVidValue?["is_video"] as? String ?? ""
                                       
                                        var eventChallengeEntity = EventChallengeEntity()
                                        eventChallengeEntity.EventImageVidUrl = self.challengeImgVidUrl+challengePict
                                        if(isVid == "1"){
                                            eventChallengeEntity.IsVid = true
                                        }
                                        if(isVid == "0"){
                                            eventChallengeEntity.IsVid = false
                                        }
                                        print(eventChallengeEntity.EventImageVidUrl)
                                        print(eventChallengeEntity.IsVid)
                                        
                                         self.eventChallengeEntities.append(eventChallengeEntity)
                                        self.challengeCollectionView.reloadData()
                                        if(self.eventChallengeEntities.count>2){
                                            if(self.eventChallengeEntities.count%2==0){
                                                var const=self.eventChallengeEntities.count - 1
                                                self.eventChallengebottomConstraint.constant=CGFloat(self.constantEventChallengesScreenHeight+const*25)
                                                
                                            }
                                            else{
                                                self.eventChallengebottomConstraint.constant=CGFloat(self.constantEventChallengesScreenHeight+self.eventChallengeEntities.count*25)
                                            }
                                            
                                        }
                                        }
                                    
                                    
                                    }

                                }

                            }
                     

                        }

                         
                        })
        //self.challengeCollectionView.delegate = self
                                                      
                
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventChallengeEntities.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ChallengeCollectionViewCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.challengeTitle.text = (self.eventChallengeEntities[indexPath.item].EventImageVidUrl)
        let url = URL(string: self.eventChallengeEntities[indexPath.row].EventImageVidUrl)
        cell.challengeImage.load(url: url!)
            // var image: UIImage =
        if(self.eventChallengeEntities[indexPath.item].isVid == true){
        cell.playButton.image =  UIImage(named: "playIcon")!
        }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y

        if scrollView == self.eventChallengesScroller {
            if yOffset >= scrollViewContentHeight - screenHeight {
                scrollView.isScrollEnabled = false
                self.challengeCollectionView.isScrollEnabled = true
            }
        }

        if scrollView == self.challengeCollectionView {
            if yOffset <= 0 {
                self.eventChallengesScroller.isScrollEnabled = true
                self.challengeCollectionView.isScrollEnabled = false
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 200.0;//Choose your custom row height
       }
       func collectionView(_ tableView: UICollectionView, widthForRowAt indexPath: IndexPath) -> CGFloat {
        return self.eventChallengesScroller.contentSize.width+1000;//Choose your custom row height
       }

    func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
      

        self.challengeCollectionView.reloadData() // ...and it is also visible here.
    }
}
