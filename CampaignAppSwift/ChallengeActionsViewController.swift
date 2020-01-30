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
