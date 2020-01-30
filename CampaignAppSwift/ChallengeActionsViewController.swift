//
//  ChallengeActionsViewController.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 29/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit
import Firebase 
class ChallengeActionsViewController: UIViewController {
var challengeTitle = ""
var challengeDesc = ""
    var challengeActionTitles: [String] = []
    var challengeActionEntities: [ChallengeActionEntity] = []
var challengeImageVidUrl = ""
var challengeId = ""
    var challengeImgVidUrl = "https://campaigndata-campaign.appspot.com/?t=vidupd&file="

    @IBOutlet weak var challengeActionsTableView: UITableView!
    
  
    @IBOutlet weak var challengTitleLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var challengeDescLabel: UILabel!
    var refProfile: FirebaseApp!
       var ref: DatabaseReference!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        challengTitleLabel.text = self.challengeTitle
        challengeDescLabel.text = self.challengeDesc
        ref = Database.database().reference()
        let url = URL(string: challengeImageVidUrl)
        let actions = ref.child("profilechallengesactions").child("1000116942").child(self.challengeId)
        actions.observeSingleEvent(of: .value) { (DataSnapshot) in
            let profileChallengesActions = DataSnapshot.value as? [String : AnyObject] ?? [:]
            for (key,value) in profileChallengesActions{
                self.challengeActionTitles.append(key)
            }
            for action in self.challengeActionTitles{
                let specificActions = self.ref.child("action").child(action)
                
                specificActions.observeSingleEvent(of: .value) { (DataSnapshot) in
                    let actionDict=DataSnapshot.value as? NSDictionary
                   let actionTitle = actionDict?["title"] as? String ?? ""
                    let actionDesc = actionDict?["descrip"] as? String ?? ""
                   let actionImgUrl = actionDict?["pict"] as? String ?? ""
                   print(actionDesc)
                }
                
                
            }
            
            
        }
        
 
        if(challengeImageVidUrl.contains(".mp4")){
     
           // let videoURL = URL(string: challengeImgVidUrl+self.challengeImageVidUrl)
           guard let url = URL(string: challengeImgVidUrl+self.challengeImageVidUrl) else { return }
            let player = AVPlayer(url: url)
            player.rate = 1 //auto play
            let playerFrame = CGRect(x: challengeImageView.frame.origin.x, y: challengeImageView.frame.origin.y+50, width: challengeImageView.frame.width, height: challengeImageView.frame.height)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.view.frame = playerFrame

            addChild(playerViewController)
            view.addSubview(playerViewController.view)
            playerViewController.didMove(toParent: self)
            playerViewController.player?.pause()
        }
        else{
            let url = URL(string: challengeImageVidUrl)
            challengeImageView.load(url: url!)
            
        }
        
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
