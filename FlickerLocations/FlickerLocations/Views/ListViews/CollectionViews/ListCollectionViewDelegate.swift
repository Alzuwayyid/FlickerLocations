//
//  ListCollectionViewDelegate.swift
//  FlickerLocations
//
//  Created by Mohammed on 30/11/2020.
//

import UIKit

class ListCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    var photos = [PhotoStruct]()
    private let imageStore = ImageStore()
    var photoFetcher = fetcher()
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath){
        let photo = photos[indexPath.row]
        photoFetcher.fetchImage(for: photo) { (result)->Void  in
            guard let photoIndex = self.photos.firstIndex(of: photo), case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            // When the request finishes, find the current cell for this photo
            if let cell = collectionView.cellForItem(at: photoIndexPath) as? PhotosListCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }
    
}
