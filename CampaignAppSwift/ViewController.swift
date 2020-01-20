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
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
   // let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.red, UIColor.brown]

    @IBOutlet weak var tableView: UITableView!
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"
      
  
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
   
    @IBOutlet weak var ring: UICircularProgressRing!
    @IBOutlet weak var descriptor: UILabel!
    @IBOutlet weak var events: UILabel!

    var refProfile: FirebaseApp!
    var ref: DatabaseReference!
    var number_of_prof_events = 0
     var number_of_total_events = 0
    var url="https://campaigndata-campaign.appspot.com/?t=upd&w=500&crop=true&file="
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "NewEventTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        FirebaseApp.configure()
        self.ring.value = 0
        // Change any of the properties you'd like
       //  let progressRing = UICircularProgressRing()
        ref = Database.database().reference()
        let collid = ref.child("profile").child("1000116942")
        let profEventChallenges=ref.child("profileeventchallenges").child("1000116942")
        let totalEventChallenges=ref.child("eventchallenges")
        
       
        
        collid.observeSingleEvent(of : .value, with : {(Snapshot) in
            let value = Snapshot.value as? NSDictionary
            let username = value?["firstname"] as? String ?? ""
            let descriptionfinal=value?["descrip"] as? String ?? ""
            let imageUrl=value?["avatar"] as? String ?? ""
            self.Name.text=username
            self.Name.numberOfLines=6
            self.view.bringSubviewToFront(self.events)
    self.descriptor.text=descriptionfinal
      
            let urlImage=URL(string:self.url+imageUrl)
            self.image.load(url: urlImage!)
            
            })
        
        
        profEventChallenges.observeSingleEvent(of : .value, with : {(Snapshot) in
            
            self.number_of_prof_events=Int(Snapshot.childrenCount)
            
             let profEventChallengesDict = Snapshot.value as? [String : AnyObject] ?? [:]
            totalEventChallenges.observeSingleEvent(of : .value, with : {(snapshot) in
            self.number_of_total_events=Int(snapshot.childrenCount)
        self.ring.value=CGFloat(self.number_of_prof_events)/CGFloat(self.number_of_total_events)*100
            let totalEventChallengesDict = snapshot.value as? [String : AnyObject] ?? [:]
            for (key, value) in totalEventChallengesDict{
                if profEventChallengesDict[key] != nil{
                    totalEventChallenges.child(key).observeSingleEvent(of : .value, with : {(Datasnapshot) in
                        let profEventChallengesDetailsDict = Datasnapshot.value as? [String : AnyObject] ?? [:]
                        for (key,value) in profEventChallengesDetailsDict{
                            print(value)
                        }
                        
                    })
                }
            }
                 })
            
                })
       
        
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 5
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell:NewEventTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! NewEventTableViewCell

                // cell.EventName.backgroundColor = self.colors[indexPath.row]
                 cell.EventName.text = self.animals[indexPath.row]

                 return cell
      }
      
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2){
            self.ring.value = 0
          
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
