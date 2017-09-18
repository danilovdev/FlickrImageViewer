//
//  ImageTableViewCell.swift
//  FlickrImageViewer
//
//  Created by Alexey Danilov on 17/09/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var flickrImageView: UIImageView!
    
    @IBOutlet weak var flickrImageTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
