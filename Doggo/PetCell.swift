//
//  PetCell.swift
//  Doggo
//
//  Created by Harrison Melton on 11/12/16.
//  Copyright © 2016 Harrison Melton. All rights reserved.
//

import UIKit

class PetCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var favoritesImage: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Add gradients for better visibility of items on top of images
        //self.addShadeGradient(view: self.infoView, fromBottom: true)
        self.addShadeGradient(view: self.buttonsView, fromBottom: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // This function adds a gradient to the view passed to it
    private func addShadeGradient(view: UIView, fromBottom: Bool) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7).cgColor]
        if !fromBottom {
            gradient.startPoint = CGPoint(x: 0, y:1)
            gradient.endPoint = CGPoint.zero
        }
        view.layer.insertSublayer(gradient, at: 0)
    }

}
