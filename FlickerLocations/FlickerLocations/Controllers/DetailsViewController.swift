//
//  DetailsViewController.swift
//  FlickerLocations
//
//  Created by Mohammed on 02/12/2020.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ownerLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    // MARK: - Properities
    var imageURL: String = ""
    var titleText: String = ""
    var address: String = ""
    var takenDate: String = ""
    var ownerName: String = ""
    var Photodescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        locationLabel.text = address
        dateLabel.text = takenDate
        ownerLabel.text = ownerName
        descriptionTextView.text = Photodescription
        
        AF.request(URL(string: imageURL)!,method: .get).response{ [self]
            (response) in
            
            switch response.result{
                
                case .success(let photoData):
                    self.photoImageView.image = UIImage(data: photoData!, scale: 1)
                    
                case .failure(let error):
                    print("Error while fetching image from URL: \(error)")
            }
        }
        
    }
    


}
