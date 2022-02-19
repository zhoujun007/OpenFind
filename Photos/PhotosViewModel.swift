//
//  PhotosViewModel.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 2/12/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Photos
import UIKit

class PhotosViewModel: ObservableObject {
    var realmModel: RealmModel?
    var assets: PHFetchResult<PHAsset>?
    var photos = [Photo]()
    var sections = [PhotosSection]()

    var reload: (() -> Void)?

    /// PHAsset caching
    let imageManager = PHCachingImageManager()
    var previousPreheatRect = CGRect.zero
    
    var animatingSlides = false
    /// the slides' current status
    var slidesState: PhotosSlidesState?
    
    /// about to present slides, set the transition
    var transitionAnimatorsUpdated: ((PhotosViewController, PhotosSlidesViewController) -> Void)?
    
    /// the photo manager got an image, update the transition image view's image.
    var imageUpdatedWhenPresentingSlides: ((UIImage?) -> Void)?
    
    
    var scanningIconTapped: (() -> Void)?
    @Published var scanningState = PhotosScanningState()
    @Saved(Defaults.scanOnLaunch.0) var scanOnLaunch = Defaults.scanOnLaunch.1
    @Saved(Defaults.scanInBackground.0) var scanInBackground = Defaults.scanInBackground.1
    @Saved(Defaults.scanWhileCharging.0) var scanWhileCharging = Defaults.scanWhileCharging.1
}

extension PhotosViewModel {
    
    /// get from `photos`
    func getPhotoIndex(photo: Photo) -> Int? {
        if let firstIndex = photos.firstIndex(of: photo) {
            return firstIndex
        }
        return nil
    }
    
    /// get from `sections`
    func getPhotoIndexPath(photo: Photo) -> IndexPath? {
        for sectionIndex in sections.indices {
            if let photoIndex = sections[sectionIndex].photos.firstIndex(of: photo) {
                return IndexPath(item: photoIndex, section: sectionIndex)
            }
        }
        return nil
    }
}

extension PHAsset {
    func getDateCreatedCategorization() -> PhotosSection.Categorization? {
        if
            let components = creationDate?.get(.year, .month, .day),
            let year = components.year, let month = components.month, let day = components.day
        {
            let categorization = PhotosSection.Categorization.date(year: year, month: month, day: day)
            return categorization
        }
        return nil
    }
}
