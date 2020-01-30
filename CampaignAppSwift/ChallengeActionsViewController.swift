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

class ChallengeActionsViewController: UIViewController {
var challengeTitle = ""
var challengeDesc = ""
var challengeImageVidUrl = ""
    var challengeImgVidUrl = "https://campaigndata-campaign.appspot.com/?t=vidupd&file="

    
  
    @IBOutlet weak var challengTitleLabel: UILabel!
    @IBOutlet weak var challengeImageView: UIImageView!
    @IBOutlet weak var challengeDescLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        challengTitleLabel.text = self.challengeTitle
        challengeDescLabel.text = self.challengeDesc
        
        let url = URL(string: challengeImageVidUrl)
            
        if(challengeImageVidUrl.contains(".mp4")){
        print(self.challengeImageVidUrl)
            let videoURL = URL(string: challengeImgVidUrl+self.challengeImageVidUrl)
            let player = AVPlayer(url: videoURL!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            playerLayer.frame = CGRect(x: 0, y: 0, width: 352, height: 180)
            self.view.layer.addSublayer(playerLayer)
            player.play()
            print(challengeImgVidUrl+self.challengeImageVidUrl)
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
