//
//  ListsConstants.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 1/21/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    

import UIKit

struct ListsCollectionConstants {
    static var minCellWidth = CGFloat(300)
    static var sidePadding = CGFloat(16)
    static var cellSpacing = CGFloat(16)
}

struct ListsCellConstants {
    static var cornerRadius = CGFloat(12)
    
    static var titleColor = UIColor.white
    static var descriptionColor = UIColor.white.withAlphaComponent(0.85)
    static var chipBackgroundColor = UIColor.secondarySystemBackground
    
    static var headerTitleFont = UIFont.preferredFont(forTextStyle: .headline)
    static var headerDescriptionFont = UIFont.preferredFont(forTextStyle: .body)
    
    static var headerImageRightPadding = CGFloat(6)
    static var headerTextSpacing = CGFloat(10)
    
    static var headerEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
    
    /// hugs the chips
    static var contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    static var chipCornerRadius = CGFloat(8)
    static var chipFont = UIFont.preferredFont(forTextStyle: .body)
    static var chipEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
    static var chipSpacing = CGFloat(8)
    static var maxNumberOfChipLines = 2
    
}

struct ListsDetailConstants {
    
    /// spacing between header and words
    static var containerSpacing = CGFloat(16)
    
    static var contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 20, right: 16)
    
    static var headerTitleFont = UIFont.preferredFont(forTextStyle: .headline)
    static var headerDescriptionFont = UIFont.preferredFont(forTextStyle: .body)
    
    static var headerTextColor = UIColor.white
    static var headerPlaceholderColor = UIColor.white.withAlphaComponent(0.75)
    
    static var headerTitleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    static var headerDescriptionEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    static var headerSpacing = CGFloat(10)
    static var headerContentPadding = CGFloat(16)
    
    static var headerCornerRadius = CGFloat(16)
    static var headerInnerViewCornerRadius = CGFloat(12)
    static var headerInnerViewBackgroundColor = UIColor.white.withAlphaComponent(0.3)
    
    static var wordsCornerRadius = CGFloat(16)
    static var wordsHeaderTitleFont = UIFont.preferredFont(forTextStyle: .headline)
    static var wordsHeaderActionsFont = UIFont.preferredFont(forTextStyle: .body)
    
    static var wordsHeaderTitleEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    static var wordsHeaderActionsEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)

    static var listSpacing = CGFloat(12)
    
    /// edge insets of everything inside the row
    static var listRowContentEdgeInsets = UIEdgeInsets(top: listSpacing / 2, left: 16, bottom: listSpacing / 2, right: 16)
    
    /// edge insets of the word chip
    static var listRowWordEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    static var listRowWordFont = UIFont.preferredFont(forTextStyle: .body)
    static var listRowWordTextColor = UIColor.label
    static var listRowWordPlaceholderColor = UIColor.label.withAlphaComponent(0.75)
    static var listRowWordCornerRadius = CGFloat(8)
    static var listRowWordBackgroundColor = UIColor.secondarySystemBackground
    
    static var wordRowHeight: CGFloat = {
        ListsDetailConstants.listRowWordFont.lineHeight
        + ListsDetailConstants.listRowContentEdgeInsets.top
        + ListsDetailConstants.listRowContentEdgeInsets.bottom
        + ListsDetailConstants.listRowWordEdgeInsets.top
        + ListsDetailConstants.listRowWordEdgeInsets.bottom
    }()
    
    static var editAnimationDuration = CGFloat(0.3)
}
