//
//  ListModel.swift
//  Find
//
//  Created by Andrew on 1/2/20.
//  Copyright © 2020 Andrew. All rights reserved.
//


import UIKit
import RealmSwift

class FindList: Object {
    @objc dynamic var name = ""
    @objc dynamic var descriptionOfList = ""
    @objc dynamic var contents = ""
    @objc dynamic var iconImageName = ""
    @objc dynamic var iconColorName = ""
  //@objc dynamic var created = Date()
}
