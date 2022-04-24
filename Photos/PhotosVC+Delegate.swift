//
//  PhotosVC+Delegate.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 2/12/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import SwiftUI

/// Scroll view
extension PhotosViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateNavigationBlur(with: scrollView)

        /// For photos caching
        updateCachedAssets()
    }

    /// update the blur with a scroll view's content offset
    func updateNavigationBlur(with scrollView: UIScrollView) {
        let contentOffset = -scrollView.contentOffset.y
        additionalSearchBarOffset = contentOffset - baseSearchBarOffset - searchViewModel.getTotalHeight()
        updateNavigationBar?()
    }

    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        if model.isSelecting {
            return true
        } else {
            return false
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if model.isSelecting {
            if model.resultsState != nil {
                photoResultsSelected(at: indexPath)
            } else {
                photoSelected(at: indexPath)
            }
        } else {
            if let resultsState = model.resultsState {
                if let findPhoto = resultsState.displayedFindPhotos[safe: indexPath.item] {
                    presentSlides(startingAtFindPhoto: findPhoto)
                }
            } else {
                if let photo = model.displayedSections[safe: indexPath.section]?.photos[safe: indexPath.item] {
                    presentSlides(startingAtPhoto: photo)
                }
            }

            collectionView.deselectItem(at: indexPath, animated: false)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if model.isSelecting {
            if model.resultsState != nil {
                photoResultsDeselected(at: indexPath)
            } else {
                photoDeselected(at: indexPath)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard model.resultsState == nil else { return nil }
        guard let photo = model.displayedSections[safe: indexPath.section]?.photos[safe: indexPath.item] else { return nil }

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in

            // Create an action for sharing
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                print("Sharing \(photo)")
            }

            let star: UIAction
            if photo.isStarred {
                star = UIAction(title: "Unstar", image: UIImage(systemName: "star")) { action in
                    print("Unstar \(photo)")
                }
            } else {
                star = UIAction(title: "Star", image: UIImage(systemName: "star.fill")) { action in
                    print("Star \(photo)")
                }
            }

            let ignore: UIAction
            if photo.isIgnored {
                ignore = UIAction(title: "Unigore", image: UIImage(systemName: "nosign")) { action in
                    print("unignore \(photo)")
                }
            } else {
                ignore = UIAction(title: "Ignore", image: UIImage(systemName: "nosign")) { action in
                    print("ignore \(photo)")
                }
            }

            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash")) { action in
                print("Sharing \(photo)")
            }

            // Create other actions...

            return UIMenu(title: "", children: [share, star, ignore, delete])
        }
    }
}
