//
//  HPhotoCell.swift
//  Find
//
//  Created by Andrew on 11/25/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class HPhotoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heartView: UIImageView!
    @IBOutlet weak var cachedView: UIImageView!
    @IBOutlet weak var checkmarkView: UIImageView!
    
    @IBOutlet weak var pinkTintView: UIView!
    @IBOutlet weak var highlightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkmarkView.alpha = 0
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        pinkTintView.snp.makeConstraints { (make) in
            make.edges.equalTo(imageView)
        }
        highlightView.snp.makeConstraints { (make) in
            make.edges.equalTo(imageView)
        }
    }
//    override var isHighlighted: Bool {
//        didSet {
//            print("kjshdf")
//            if isHighlighted {
//                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//                }, completion: nil)
//            } else {
//                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
//                }, completion: nil)
//            }
//        }
//    }
//    override var isSelected: Bool {
//        didSet {
//            print("setted")
//            if isSelected == true {
//                //super.isSelected = true
//                print("highlighted")
//                imageView.snp.remakeConstraints { (remake) in
//                    remake.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//                    print("remake")
//                }
//                //cell.isSelected = false
////                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
//                    UIView.animate(withDuration: 0.1, animations: {
//                        self.checkmarkView.alpha = 1
//                        self.layoutIfNeeded()
//                    })
////                })
////                UIView.animate(withDuration: 0.1, delay: 0.05, options: .curveLinear, animations: {
////                    self.checkmarkView.alpha = 1
////                    self.layoutIfNeeded()
////                }, completion: nil)
//
////                UIView.animate(withDuration: 0.12, animations: {
////
////                })
////
//
//            } else {
//                //super.isSelected = false
//                print("not highlight")
//                imageView.snp.remakeConstraints { (remake) in
//                    remake.edges.equalToSuperview()
//                    print("remake")
//                }
//                //cell.isSelected = false
//                UIView.animate(withDuration: 0.12, animations: {
//                    self.layoutIfNeeded()
//                })
////                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
////                    UIView.animate(withDuration: 0.1, animations: {
////                        self.checkmarkView.alpha = 0
////                    })
////                })
////                UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveLinear, animations: {
////                    self.checkmarkView.alpha = 0
////                    self.layoutIfNeeded()
////                }, completion: nil)
//                UIView.animate(withDuration: 0.1, animations: {
//                    self.checkmarkView.alpha = 0
//                    self.layoutIfNeeded()
//                })
//
//            }
//
//        }
//    }
    
}