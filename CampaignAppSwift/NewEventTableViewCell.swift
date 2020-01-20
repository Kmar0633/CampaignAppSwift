//
//  NewEventTableViewCell.swift
//  CampaignAppSwift
//
//  Created by Kevin Marcelino on 20/01/20.
//  Copyright © 2020 Kevin Marcelino. All rights reserved.
//

import UIKit

class NewEventTableViewCell: UITableViewCell {

    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
