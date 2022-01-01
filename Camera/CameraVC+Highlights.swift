//
//  CameraVC+Highlights.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 12/30/21.
//  Copyright © 2021 A. Zheng. All rights reserved.
//
    

import UIKit

extension CameraViewController {
    func setupHighlights() {
        /// for highlights, make appear after frames are set

        let highlightsViewController = HighlightsViewController(highlightsViewModel: highlightsViewModel)
        addChildViewController(highlightsViewController, in: scrollZoomViewController.drawingView)
    }
    
    
    
    func addHighlights(from sentences: [FindText]) {
        var highlights = Set<Highlight>()
        for sentence in sentences {
            for (string, gradient) in self.searchViewModel.stringToGradients {
                let indices = sentence.string.lowercased().indicesOf(string: string.lowercased())
                for index in indices {
                    let word = sentence.getWord(word: string, at: index)
                    
                    let highlight = Highlight(
                        string: string,
                        frame: word.frame.scaleTo(self.drawingViewSize),
                        colors: gradient.colors,
                        alpha: gradient.alpha
                    )
                    
                    highlights.insert(highlight)
                    
                }
            }
        }

        DispatchQueue.main.async {
            self.highlightsViewModel.update(with: highlights)
        }
    }
}
