//
//  Signup+CoreDataProperties.swift
//  CoreDataSignup
//
//  Created by Jony on 29/07/20.
//  Copyright © 2020 Jony. All rights reserved.
//
//

import Foundation
import CoreData


extension Signup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Signup> {
        return NSFetchRequest<Signup>(entityName: "Signup")
    }

    @NSManaged public var dateCreated: Date
    @NSManaged public var password: String
    @NSManaged public var phoneNumber: String

}
