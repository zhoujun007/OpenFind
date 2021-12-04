//
//  PopoverModel.swift
//  Popover
//
//  Created by Zheng on 12/3/21.
//  Copyright © 2021 Andrew. All rights reserved.
//

import Combine
import SwiftUI

class PopoverModel: ObservableObject {
    @Published var popovers = [Popover]()
}

enum Popover: Identifiable {
    var id: UUID {
        let context = extractContext()
        return context.id
    }
    var frame: CGRect {
        let context = extractContext()
        return CGRect(origin: context.origin, size: context.size)
    }
    var keepPresentedRects: [CGRect] {
        let context = extractContext()
        return context.keepPresentedRects
    }
    
    func extractContext() -> PopoverContext {
        switch self {
        case .fieldSettings(let configuration):
            return configuration.popoverContext
        }
    }
    
    case fieldSettings(PopoverConfiguration.FieldSettings)
    
}
struct PopoverConfiguration {
    struct FieldSettings {
        var popoverContext = PopoverContext()
        
        var defaultColor: UInt = 0
        var selectedColor: UInt = 0
        var alpha: CGFloat = 1
        
        var propertiesChanged: ((Self) -> Void)?
    }
}
struct PopoverContext: Identifiable {
    let id = UUID()
    
    /// position of the popover
    var origin: CGPoint = .zero
    
    /// calculated from SwiftUI
    var size: CGSize = .zero
    
    /// if click in once of these rects, don't dismiss the popover. Otherwise, dismiss.
    var keepPresentedRects: [CGRect] = []
    
}