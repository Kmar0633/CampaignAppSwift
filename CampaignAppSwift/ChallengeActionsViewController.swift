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
class ChallengeActionsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.challengeActionEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChallengeActionTableViewCell = self.challengeActionsTableView.dequeueReusableCell(withIdentifier: "cell1") as! ChallengeActionTableViewCell
        cell.challengeActionTitle.text = self.challengeActionEntities[indexPath.row].ActionTitle
        cell.challengeActionDesc.text = self.challengeActionEntities[indexPath.row].ActionDesc
        let url = URL(string: self.challengeActionEntities[indexPath.row].ActionImageUrl)
        
        cell.challengeActionImage.load(url: url!)
        return cell
        
    }
       let screenHeight = UIScreen.main.bounds.height
var challengeTitle = ""
var challengeDesc = ""
    var actionImageUrl = "https://campaigndata-campaign.appspot.com/?t=act&w=500&crop=true&file="
    var challengeActionTitles: [String] = []
    var challengeActionEntities: [ChallengeActionEntity] = []
var challengeImageVidUrl = ""
var challengeId = ""
    var challengeImgVidUrl = "https://campaigndata-campaign.appspot.com/?t=vidupd&file="

    @IBOutlet weak var challengeActionsTableView: UITableView!
    
  
    @IBOutlet weak var challengeActionsScroller: UIScrollView!
    @IBOutlet weak var challengTitleLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var challengeDescLabel: UILabel!
    var scrollViewContentHeight = 1200 as CGFloat
    var refProfile: FirebaseApp!
       var ref: DatabaseReference!
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;//Choose your custom row height
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let yOffset = scrollView.contentOffset.y

        if scrollView == self.challengeActionsScroller {
               if yOffset >= scrollViewContentHeight - screenHeight {
                   scrollView.isScrollEnabled = false
                self.challengeActionsTableView.isScrollEnabled = true
               }
           }

           if scrollView == self.challengeActionsTableView {
               if yOffset <= 0 {
                   self.challengeActionsScroller.isScrollEnabled = true
                self.challengeActionsTableView.isScrollEnabled = false
               }
           }
       }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.challengeActionsScroller.contentSize = CGSize(width:300, height:scrollViewContentHeight-90)
        self.challengeActionsTableView.frame.size = CGSize(width:300, height:self.challengeActionsTableView.contentSize.height+1000)
        self.challengeActionsScroller.isScrollEnabled=true
       
        self.challengeActionsScroller.layoutIfNeeded()
        self.challengeActionsTableView.isScrollEnabled=false
        challengTitleLabel.text = self.challengeTitle
        challengeDescLabel.text = self.challengeDesc
        ref = Database.database().reference()
        self.challengeActionsTableView.delegate=self
    self.challengeActionsTableView.dataSource=self
        
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
                   var challengeActionEntity = ChallengeActionEntity()
                    challengeActionEntity.ActionDesc = actionDesc
                    challengeActionEntity.ActionImageUrl = self.actionImageUrl+actionImgUrl
                    challengeActionEntity.ActionTitle = actionTitle
                    self.challengeActionEntities.append(challengeActionEntity)
                    print(actionImgUrl)
                    self.challengeActionsTableView.reloadData()
                    
                }
                
                
            }
            
            
        }
        
 
        if(challengeImageVidUrl.contains(".mp4")){
     
           // let videoURL = URL(string: challengeImgVidUrl+self.challengeImageVidUrl)
           guard let url = URL(string: challengeImgVidUrl+self.challengeImageVidUrl) else { return }
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player )
            player.rate = 1 //auto play
            let playerFrame = CGRect(x: challengeImageView.frame.origin.x , y: challengeImageView.frame.origin.y+50 + self.challengeActionsScroller.contentOffset.y, width: challengeImageView.frame.width, height: challengeImageView.frame.height)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.view.frame = playerFrame
            addChild(playerViewController)
        
             playerViewController.didMove(toParent: self)
            playerViewController.player?.pause()
            self.view.addSubview(playerViewController.view)
        }
        else{
            let url = URL(string: challengeImageVidUrl)
            challengeImageView.load(url: url!)
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

        print("scrollViewWillBeginDecelerating")

        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        print(actualPosition.y)
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
