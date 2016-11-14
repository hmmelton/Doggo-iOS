//
//  PetCell.swift
//  Doggo
//
//  Created by Harrison Melton on 11/12/16.
//  Copyright © 2016 Harrison Melton. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
