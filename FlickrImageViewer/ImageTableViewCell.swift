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
    
    func configure(imageEntity: ImageEntity) {
        self.flickrImageTitle.text = imageEntity.title
        if let url = URL(string: imageEntity.imageUrlStr) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                OperationQueue.main.addOperation {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.flickrImageView.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }

    
}
