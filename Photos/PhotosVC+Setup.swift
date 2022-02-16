//
//  PhotosVC+Setup.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 2/14/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import Photos
import SwiftUI

extension PhotosViewController {
    func setup() {
        setupCollectionView()
        setupAssetCaching()
        checkPermissions()
        listenToModel()
    }

    func checkPermissions() {
        switch permissionsViewModel.currentStatus {
        case .notDetermined:
            showPermissionsView()
        case .restricted:
            showPermissionsView()
        case .denied:
            showPermissionsView()
        case .authorized:
            loadCollectionView()
        case .limited:
            loadCollectionView()
        @unknown default:
            fatalError()
        }
    }

    func showPermissionsView() {
        collectionView.alpha = 0
        let permissionsView = PhotosPermissionsView(model: permissionsViewModel)
        let hostingController = UIHostingController(rootView: permissionsView)
        addChildViewController(hostingController, in: view)
        view.bringSubviewToFront(hostingController.view)
        permissionsViewModel.permissionsGranted = { [weak self] in
            guard let self = self else { return }
            self.loadCollectionView()
        }
    }

    /// Call this after `loadCollectionView()`.
    func showCollectionView() {
        UIView.animate(withDuration: 0.5) {
            self.collectionView.alpha = 1
        }
    }
}

extension PhotosViewController {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.allowsSelection = false
        collectionView.delaysContentTouches = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.keyboardDismissMode = .interactive
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset.top = searchViewModel.getTotalHeight()
        collectionView.verticalScrollIndicatorInsets.top = searchViewModel.getTotalHeight() + SearchNavigationConstants.scrollIndicatorTopPadding
        
        collectionView.collectionViewLayout = flowLayout
    }
}