//
//  UIGalleryPager.swift
//  Doggo
//
//  Created by Harrison Melton on 11/23/16.
//  Copyright © 2016 Harrison Melton. All rights reserved.
//

import UIKit

class UIGalleryPager: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var imgUrls: [String]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization
        self.setUpImageScroller(numImages: self.imgUrls.count)
    }
    
    // MARK: Functions
    // This function sets up the UIScrollView to act as an image pager
    private func setUpImageScroller(numImages: Int) {
        // Get width & height of scroll view
        let scrollViewWidth: CGFloat = self.frame.width
        let scrollViewHeight: CGFloat = self.frame.height
        
        // Prepare for image downloads
        let backgroundQ = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        
        for index in 0..<numImages {
            // Create a new UIImageView for each image, and set image
            group.enter()
            let img = UIImageView(frame: CGRect(x:CGFloat(index)*scrollViewWidth, y:0, width: scrollViewWidth, height: scrollViewHeight))
            img.image = UIImage(ciImage: CIImage(contentsOf: URL(string: self.imgUrls[index])!)!)
            self.addSubview(img)
        }
        // Set content size of image pager to be the sum of the widths of the images
        self.contentSize = CGSize(width: self.frame.width * CGFloat(numImages), height: self.frame.height)
    }

}
