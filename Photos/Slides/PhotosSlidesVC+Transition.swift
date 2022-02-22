//
//  PhotosSlidesVC+Transition.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 2/17/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    
import UIKit

extension PhotosSlidesViewController: PhotoTransitionAnimatorDelegate {
    func transitionWillStart(type: PhotoTransitionAnimatorType) {
        switch type {
        case .push:
            break
        case .pop:
            if let containerView = getCurrentItemContainerView() {
                containerView.alpha = 0
            }
        }
    }

    func transitionDidEnd(type: PhotoTransitionAnimatorType) {
        if let containerView = getCurrentItemContainerView() {
            containerView.alpha = 1
        }
    }
    
    func referenceImage(type: PhotoTransitionAnimatorType) -> UIImage? {
        if let imageView = getCurrentItemImageView() {
            return imageView.image
        }
        return nil
    }
    
    func imageFrame(type: PhotoTransitionAnimatorType) -> CGRect? {
        if let imageView = getCurrentItemImageView() {
            let frame = imageView.windowFrame()
            let thumbnail = getCurrentFindPhoto()?.thumbnail
            let normalizedFrame = CGRect.makeRect(aspectRatio: thumbnail?.size ?? .zero, insideRect: frame)
            return normalizedFrame
        }
        return nil
    }
    
    func getCurrentFindPhoto() -> FindPhoto? {
        if
            let currentIndex = model.slidesState?.currentIndex,
            let findPhoto = model.slidesState?.findPhotos[safe: currentIndex]
        {
            return findPhoto
        }
        return nil
    }
    
    func getCurrentItemViewController() -> PhotosSlidesItemViewController? {
        if let viewController = getCurrentFindPhoto()?.associatedViewController {
            return viewController
        }
        return nil
    }
    
    func getCurrentItemContainerView() -> UIView? {
        if
            let viewController = getCurrentItemViewController(),
            let containerView = viewController.containerView
        {
            return containerView
        }
        return nil
    }
    
    func getCurrentItemImageView() -> UIImageView? {
        if
            let viewController = getCurrentItemViewController(),
            let imageView = viewController.scrollZoomController.imageView
        {
            return imageView
        }
        return nil
    }
}