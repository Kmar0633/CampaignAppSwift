//
//  ChallengeActionTableViewCell.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 30/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit

class ChallengeActionTableViewCell: UITableViewCell {
    @IBOutlet weak var challengeActionImage: UIImageView!
    @IBOutlet weak var challengeActionTitle: UILabel!
    @IBOutlet weak var challengeActionDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
