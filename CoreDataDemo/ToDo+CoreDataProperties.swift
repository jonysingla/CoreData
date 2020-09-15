//
//  ToDo+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Jony on 28/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var todoName: String
    @NSManaged public var todoDescription: String
    @NSManaged public var todoImage: Data
    @NSManaged public var dateCreated: Date

}
