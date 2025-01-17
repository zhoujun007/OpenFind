//
//  Utilities+UIFont.swift
//  Find
//
//  Created by Zheng on 11/21/21.
//  Copyright © 2021 Andrew. All rights reserved.
//

import SwiftUI

extension UIFont {
    /// https://mackarous.com/dev/2018/12/4/dynamic-type-at-any-font-weight
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        if let descriptor = fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: 0) // size 0 means keep the size as it is
        } else {
            return self
        }
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }

    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }

    func sizeOfString(_ string: String) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: self]
        let size = (string as NSString).size(withAttributes: fontAttributes)
        return size
    }
}

extension UIFont {
    
    /// SwiftUI font
    var font: Font {
        return Font(self as CTFont)
    }
}

extension UIFont {
    static func preferredCustomFont(forTextStyle textStyle: TextStyle, weight: Weight) -> UIFont {
        let defaultDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        let size = defaultDescriptor.pointSize
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.size: size,
            UIFontDescriptor.AttributeName.family: UIFont.systemFont(ofSize: size).familyName
        ])

        // Add the font weight to the descriptor
        let weightedFontDescriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])
        return UIFont(descriptor: weightedFontDescriptor, size: 0)
    }
    
    static func preferredMonospacedFont(forTextStyle textStyle: TextStyle, weight: Weight) -> UIFont {
        let defaultDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        let size = defaultDescriptor.pointSize
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.size: size,
            UIFontDescriptor.AttributeName.family: UIFont.monospacedSystemFont(ofSize: size, weight: weight).familyName,
        ])

        // Add the font weight to the descriptor
        let weightedFontDescriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])
        return UIFont(descriptor: weightedFontDescriptor, size: 0)
    }
    
    static func safeFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size) ?? .systemFont(ofSize: size)
        return font
    }
}
