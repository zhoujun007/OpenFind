//
//  PhotosVC+EmptyContent.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 3/26/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

extension PhotosViewController {
    func setupEmptyContent() {
        let viewController = UIHostingController(
            rootView: PhotosEmptyContentView(
                model: model,
                sliderViewModel: sliderViewModel
            )
        )
        addChildViewController(viewController, in: contentContainer)
        contentContainer.alpha = 0
    }

    func showEmptyContent(_ show: Bool) {
        if show {
            UIView.animate(withDuration: 0.3) {
                self.contentContainer.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.contentContainer.alpha = 0
            }
        }
    }
}
