//
//  PhotosListCollectionViewCell.swift
//  FlickerLocations
//
//  Created by Mohammed on 30/11/2020.
//

import UIKit

class PhotosListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var distanceLabel: UILabel!
    
    func update(displaying image: UIImage?){
        if let imageToDisplay = image {
//            spinner.stopAnimating()
            photoImageView.image = imageToDisplay
        }
        else{
//            spinner.startAnimating()
            photoImageView.image = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 15

        let margins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.backgroundColor = UIColor(named: "MapGrayColor")!.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.3
        contentView.tintColor = .white
        self.backgroundColor = .clear

    }
}
