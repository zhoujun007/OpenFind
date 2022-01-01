//
//  CameraVC+Find.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 12/30/21.
//  Copyright © 2021 A. Zheng. All rights reserved.
//


import UIKit
import AVFoundation

extension CameraViewController {
    func findAndAddHighlights(pixelBuffer: CVPixelBuffer, completion: @escaping (([FindText]) -> Void) = { _ in }) {
        var options = FindOptions()
        options.orientation = .right
        
        find(in: .pixelBuffer(pixelBuffer), options: options) { [weak self] sentences in
            completion(sentences)
            self?.addHighlights(from: sentences)
        }
    }
    
    func findAndAddHighlights(image: CGImage, completion: @escaping (([FindText]) -> Void) = { _ in }) {
        var options = FindOptions()
        options.orientation = .up
        options.level = .accurate
        find(in: .cgImage(image), options: options) { [weak self] sentences in
            completion(sentences)
            self?.addHighlights(from: sentences)
        }
    }
    
    func find(in image: FindImage, options: FindOptions, completion: @escaping (([FindText]) -> Void)) {
        guard Find.startTime == nil else { return }
        Find.run(in: image, options: options) { sentences in
            completion(sentences)
        }
    }
}