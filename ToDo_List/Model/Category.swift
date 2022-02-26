//
//  Category.swift
//  ToDo_List
//
//  Created by Abdelnasser on 26/02/2022.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name :String=""

    let items = List<Item>()
}
