//
//  PhotosMigrationController.swift
//  Find
//
//  Created by Zheng on 1/1/21.
//  Copyright © 2021 Andrew. All rights reserved.
//

import UIKit
import Photos
import SDWebImage

class PhotosMigrationController: UIViewController {
    
    let dispatchGroup = DispatchGroup()
    var numberCompleted = 0
    
//    let assets = [PHAsset]()
    var photoURLs = [URL]()
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var movePhotosLabel: UILabel!
    
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBAction func confirmButtonPressed(_ sender: Any) {
        writeToPhotos(photoURLs: photoURLs)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    let scale = UIScreen.main.scale // Will be 2.0 on 6/7/8 and 3.0 on 6+/7+/8+ or later
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var segmentIndicator: ANSegmentIndicator!
    @IBOutlet weak var movingLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        blurView.effect = nil
        segmentIndicator.alpha = 0
        movingLabel.alpha = 0
        progressLabel.alpha = 0
        progressLabel.text = "0%"
        
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 12
        
        var settings = ANSegmentIndicatorSettings()
        
        settings.segmentColor = UIColor(named: "100Blue")!
        settings.defaultSegmentColor = UIColor.systemBackground
        
        settings.segmentBorderType = .round
        settings.segmentsCount = min(50, photoURLs.count)
        settings.segmentWidth = 5
        settings.animationDuration = 0.2
        settings.spaceBetweenSegments = Degrees(2)
        
        segmentIndicator.settings = settings
    }
}

extension PhotosMigrationController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = photoURLs[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        let thumbnailSize = CGSize(width: 200 * scale, height: 200 * scale)
        
        cell.imageView.sd_imageTransition = .fade
        cell.imageView.sd_setImage(with: url, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fullWidth = collectionView.bounds.width
        let edgePadding =  collectionView.contentInset.left
        let numberPerRow = CGFloat(4)
        let totalPadding = edgePadding * CGFloat(numberPerRow + 1)
        let eachCellWidth = (fullWidth - totalPadding) / numberPerRow
        let eachCellSize = CGSize(width: eachCellWidth, height: eachCellWidth)
        
        return eachCellSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.contentInset.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.contentInset.left
    }
}