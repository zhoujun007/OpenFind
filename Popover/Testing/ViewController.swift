//
//  ViewController.swift
//  Popover
//
//  Created by Zheng on 12/3/21.
//  Copyright © 2021 Andrew. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

//    lazy var popoverController: PopoverController = {
//        
//        let window = UIApplication.shared
//        .connectedScenes
//        .filter { $0.activationState == .foregroundActive }
//        .first
//        
//        if let windowScene = SceneConstants.savedScene {
//            let popoverController = PopoverController(
//                popoverModel: popoverModel,
//                windowScene: windowScene
//            )
//            return popoverController
//        }
//        
//        fatalError("NO scene")
//    }()
    
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var listLabel: UILabel!
    
    var fields = [
        Field(text: .init(value: .string(""), colorIndex: 0)),
        Field(text: .init(value: .list(
            List(
                name: "List",
                desc: "Desc",
                contents: ["Word", "Branch", "Water", "Dirt"],
                iconImageName: "plus",
                iconColorName: 0x00aeef,
                dateCreated: Date()
            )
        ), colorIndex: 1)),
        Field(text: .init(value: .addNew(""), colorIndex: 2))
    ]
    
    //    var fieldSettingsModel = FieldSettingsModel()
    
    @IBAction func wordPressed(_ sender: Any) {
        let fieldSettingsModel = FieldSettingsModel()
        fieldSettingsModel.header = "WORD"
        fieldSettingsModel.defaultColor = self.fields[0].text.color
        fieldSettingsModel.selectedColor = self.fields[0].text.color
        fieldSettingsModel.alpha = self.fields[0].text.colorAlpha
        fieldSettingsModel.words = []
        fieldSettingsModel.showingWords = false
        fieldSettingsModel.editListPressed = nil
        
        let popoverView = AnyView(FieldSettingsView(model: fieldSettingsModel, draggingEnabled: Popovers.model.draggingEnabled))
        var popover = Popover(view: popoverView)
        popover.context.position = self.wordLabel.popoverOrigin(anchor: .bottomLeft)
        popover.context.dismissMode = .tapOutside(
            .init(
                animation: .spring(),
                excludedRects: [
                    self.purpleButton.windowFrame(),
                    self.listButton.windowFrame(),
                    self.listLabel.windowFrame()
                ]
            )
        )
        Popovers.present(popover, animation: .spring())
    }
    
    @IBOutlet weak var listButton: UIButton!
    @IBAction func listPressed(_ sender: Any) {
        let fieldSettingsModel = FieldSettingsModel()
        fieldSettingsModel.header = "LIST"
        fieldSettingsModel.defaultColor = self.fields[1].text.color
        fieldSettingsModel.selectedColor = self.fields[1].text.color
        fieldSettingsModel.alpha = self.fields[1].text.colorAlpha
        fieldSettingsModel.words = ["Hello", "Other word", "Ice", "Water"]

        fieldSettingsModel.editListPressed = {
            print("Edit")
            //            if let existingFieldSettingsPopoverIndex = self.indexOfExistingFieldPopover() {
            withAnimation {
                Popovers.model.popovers.remove(at: 0)
                //                }
            }
        }
        
        let popoverView = AnyView(FieldSettingsView(model: fieldSettingsModel, draggingEnabled: Popovers.model.draggingEnabled))
        var popover = Popover(view: popoverView)
        popover.context.position = self.listLabel.popoverOrigin(anchor: .bottomLeft)
        popover.context.dismissMode = .tapOutside(
            .init(
                animation: .spring(),
                excludedRects: [
                    self.purpleButton.windowFrame(),
                    self.listButton.windowFrame(),
                    self.listLabel.windowFrame()
                ]
            )
        )
        //        if let existingFieldSettingsPopoverIndex = indexOfExistingFieldPopover() {
        if Popovers.model.popovers.indices.contains(0) {
            
            withAnimation {
                
                /// use same ID for smooth position animation
                popover.context.id = Popovers.model.popovers[0].id
                Popovers.model.popovers[0] = popover
            }
        } else {
            Popovers.present(popover, animation: .spring())
        }
        //        } else {
        //            withAnimation {
        //                let popover = Popover.fieldSettings(configuration)
        //                popoverModel.popovers.append(popover)
//            }
//        }
//        Popovers.present(popover, animation: .spring())
        
//        var configuration = PopoverConfiguration.FieldSettings(
//            popoverContext: .init(
//                position: self.listLabel.popoverOrigin(anchor: .bottomLeft),
//                keepPresentedRects: [
//                    self.purpleButton.windowFrame()
//                ]
//            ),
//            header: "LIST",
//            defaultColor: self.fields[0].text.color,
//            selectedColor: self.fields[0].text.color,
//            alpha: self.fields[0].text.colorAlpha,
//            words: ["Hello", "Other word"],
//            editListPressed: {
//                print("Edit")
//                if let existingFieldSettingsPopoverIndex = self.indexOfExistingFieldPopover() {
//                    withAnimation {
//                        self.popoverModel.popovers.remove(at: existingFieldSettingsPopoverIndex)
//                    }
//                }
//            }
//        ) { [weak self] newConfiguration in
//                guard let self = self else { return }
//                self.fields[0].text.color = newConfiguration.selectedColor
//                self.fields[0].text.colorAlpha = newConfiguration.alpha
//    
//        }
//        
//        
//        if let existingFieldSettingsPopoverIndex = indexOfExistingFieldPopover() {
//            withAnimation {
//                
//                /// use same ID for smooth position animation
//                configuration.popoverContext.id = popoverModel.popovers[existingFieldSettingsPopoverIndex].id
//                let popover = Popover.fieldSettings(configuration)
//                popoverModel.popovers[existingFieldSettingsPopoverIndex] = popover
//            }
//        } else {
//            withAnimation {
//                let popover = Popover.fieldSettings(configuration)
//                popoverModel.popovers.append(popover)
//            }
//        }
    }
    
//    func indexOfExistingFieldPopover() -> Int? {
//        return popoverModel.popovers.indices.first(where: { index in
//            if case .fieldSettings(_) = popoverModel.popovers[index] {
//                return true
//            } else {
//                return false
//            }
//        })
//    }
    
    @IBAction func tipPressed(_ sender: Any) {
    }
    
    @IBAction func holdDown(_ sender: Any) {
    }
    
    @IBAction func holdUp(_ sender: Any) {
    }
    
    @IBOutlet weak var purpleButton: UIButton!
    @IBAction func purpleButtonPressed(_ sender: Any) {
        print("purple pressed")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        _ = popoverController
    }
}


