//
//  Item.swift
//  ToDo_List
//
//  Created by Abdelnasser on 26/02/2022.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name :String=""
    @objc dynamic var checked :Bool=false
    let parent = LinkingObjects(fromType:Category.self , property:"items")
    
}
