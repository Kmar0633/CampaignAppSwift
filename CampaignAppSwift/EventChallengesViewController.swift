//
//  EventChallengesViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 21/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit

class EventChallengesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   var items = ["1", "2", "3", "4", "5", "6"]
    let reuseIdentifier = "cell"
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var challengeCollectionView: UICollectionView!
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ChallengeCollectionViewCell

        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.challengeTitle.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project

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

}
